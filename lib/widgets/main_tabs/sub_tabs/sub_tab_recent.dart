import 'package:flutter/material.dart';
import 'package:flutter_xftz/model/news_live.dart';
import 'package:flutter_xftz/model/price_quote.dart';
import 'package:flutter_xftz/utils/taskproviders.dart';
import 'package:flutter_xftz/utils/utils.dart';
import 'package:flutter_xftz/utilviews/indicator_viewpager.dart';
import 'package:flutter_xftz/utilviews/button_menu.dart';
import 'package:flutter_xftz/widgets/main_tabs/sub_tabs/quote_section.dart';
import 'package:flutter_xftz/widgets/main_tabs/sub_tabs/live_news_section.dart';

import 'dart:async';
import 'dart:math';

import 'package:intl/intl.dart';

const double _kAppBarHeight = 200.0;

class SubTabRecentPage extends StatefulWidget {
  final TaskProvider provider;

  SubTabRecentPage(this.provider, {Key key}) : super(key: key);

  @override
  SubTabRecentPageState createState() => new SubTabRecentPageState();
}

class SubTabRecentPageState extends State<SubTabRecentPage>
    with TickerProviderStateMixin {
  List<Widget> _imagePages;
  List<String> _urls = [
    'https://imgsa.baidu.com/news/q%3D100/sign=dbc6207d9e45d688a502b6a494c37dab/b64543a98226cffc062c56fcb5014a90f603ea7e.jpg',
    'https://imgsa.baidu.com/news/q%3D100/sign=11f1fc6819ce36d3a40487300af23a24/e4dde71190ef76c6edabfb999116fdfaaf516702.jpg',
    'https://imgsa.baidu.com/news/q%3D100/sign=b060b3916f2762d0863ea0bf90ed0849/b7003af33a87e9502ca6ffde1c385343faf2b4ca.jpg'
  ];
  Timer chatTimer;

  List<Quote> _quoteList;

  List<NewsLive> _liveNewsList;

  List<Quote> _quoteOldList = List<Quote>();

  void _loadLiveNews()async{
    try{
      if (mounted) {
        List<NewsLive>  liveNewsList = await widget.provider.loadLiveNews();
        print("_loadLiveNews"+liveNewsList.toString());
        setState(() {
          _liveNewsList = liveNewsList;
        });
      }
    } catch (e) {
      print("_loadLiveNews"+e);
    }
  }

  void _loadQuote(Timer chattimer) async {
    if (mounted) {

      try {
        List<Quote> quoteNewList = await widget.provider.loadQuote();
        //比较两次数据,计算涨跌
        quoteNewList = _compareQuote(quoteNewList);

        _quoteOldList = quoteNewList;

        setState(() {
          _quoteList = quoteNewList;
        });
      } catch (e) {
        print("_loadQuote"+e);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();

    chatTimer.cancel();
  }

  @override
  void initState() {
    super.initState();
    _loadQuote(null);
    _loadLiveNews();

    chatTimer = new Timer.periodic(new Duration(seconds: 5), _loadQuote);
    if (!_urls.isEmpty) {
      _imagePages = <Widget>[];
      _urls.forEach((String url) {
        _imagePages.add(new Container(
            color: Colors.black.withAlpha(900),
            child: new ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: new Image.network(
                url,
                fit: BoxFit.cover,
                height: _kAppBarHeight,
              ),
            )));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox.fromSize(
            size: Size.fromHeight(_kAppBarHeight),
            child: IndicatorViewPager(_imagePages),
          ),
          Container(
            decoration: new BoxDecoration(color: themeData.backgroundColor),
            child: Row(
              children: _buildMenuButtons(),
            ),
          ),
          new Container(
            margin: EdgeInsets.only(top: 10.0),
            decoration: new BoxDecoration(color: themeData.backgroundColor),
            child: new Padding(
                padding: const EdgeInsets.all(16.0),
                child: _quoteList == null
                    ? new Center(
                        child: new CircularProgressIndicator(),
                      )
                    : new QuoteSection(
                        _quoteList,
                        vsync: this,
                      )),
          ),
          new Container(
            margin: EdgeInsets.only(top: 10.0),
            decoration: new BoxDecoration(color: themeData.backgroundColor),
            child: new Padding(
                padding: const EdgeInsets.all(16.0),
                child: _liveNewsList == null
                    ? new Center(
                  child: new CircularProgressIndicator(),
                )
                    : NewsLiveSection (
                  _liveNewsList
                )),
          )
        ],
      ),
    );
  }

  List<Widget> _buildMenuButtons() {
    return <Widget>[
      Expanded(
        child: MenuButton(
          icons: Icons.add_to_queue,
          text: "行情",
          colors: Colors.red,
          onClickListener: (String text) {_loadLiveNews();},
        ),
      ),
      Expanded(
        child: MenuButton(
          icons: Icons.date_range,
          text: "日历",
          colors: Colors.green,
          onClickListener: (String text) {
            print(text);
          },
        ),
      ),
      Expanded(
        child: MenuButton(
          icons: Icons.fiber_new,
          text: "资讯",
          colors: Colors.indigo,
          onClickListener: (String text) {
            print(text);
          },
        ),
      ),
      Expanded(
        child: MenuButton(
          icons: Icons.dns,
          text: "头条",
          colors: Colors.blue,
          onClickListener: (String text) {
            print(text);
          },
        ),
      ),
      Expanded(
        child: MenuButton(
          icons: Icons.pages,
          text: "广场",
          colors: Colors.pink,
          onClickListener: (String text) {
            print(text);
          },
        ),
      ),
    ];
  }

  List<Quote> _compareQuote(List<Quote> quoteList) {
    return quoteList.map((Quote newQuote) {
      for (Quote old in _quoteOldList) {
        if (old.ProductCode == newQuote.ProductCode) {
          newQuote.UpsAndDowns = subFractionDigits(newQuote.Ask, old.Ask, 3);
          newQuote.UpsAndDownsRate = newQuote.UpsAndDowns / old.Ask;
        }
      }
      return newQuote;
    }).toList();
  }
}
