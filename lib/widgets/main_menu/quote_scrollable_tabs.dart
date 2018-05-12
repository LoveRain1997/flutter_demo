import 'dart:async';

// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_xftz/model/price_quote.dart';
import 'package:flutter_xftz/utils/taskproviders.dart';
import 'package:flutter_xftz/utils/utils.dart';
import 'package:flutter_xftz/widgets/main_tabs/sub_tabs/quote_card.dart';


class _Page {
  const _Page({ this.icon, this.text });
  final IconData icon;
  final String text;
}

const List<_Page> _allPages = const <_Page>[
  const _Page(icon: Icons.grade, text: '投教宝'),
  const _Page(icon: Icons.playlist_add, text: '上海黄金'),
  const _Page(icon: Icons.check_circle, text: '工商银行'),
  const _Page(icon: Icons.question_answer, text: 'NYME原油'),
  const _Page(icon: Icons.sentiment_very_satisfied, text: '中国银行'),
  const _Page(icon: Icons.camera, text: '建设银行'),
  const _Page(icon: Icons.assignment_late, text: 'IPE原油'),
  const _Page(icon: Icons.assignment_turned_in, text: '农业银行'),
  const _Page(icon: Icons.group, text: '国际现货'),
  const _Page(icon: Icons.block, text: '全球外汇'),
  const _Page(icon: Icons.sentiment_very_dissatisfied, text: '国内股指'),
  const _Page(icon: Icons.error, text: '全球指数'),
  const _Page(icon: Icons.loop, text: '大宗商品'),
];

class QutoeScrollableTabs extends StatefulWidget {
  static const String routeName = '/widgets/main_menu/quote-scrollable-tabs';

  TaskProvider provider;

  QutoeScrollableTabs({Key key}) : super(key: key){

    provider = new PriceTaskProvider();

  }

  @override
  QuoteScrollableTabsState createState() => new QuoteScrollableTabsState();
}

class QuoteScrollableTabsState extends State<QutoeScrollableTabs> with TickerProviderStateMixin {
  TabController _controller;
  Timer chatTimer;
  List<Quote> _quoteList;
  List<Quote> _quoteOldList = List<Quote>();


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
  void initState() {
    super.initState();
    _controller = new TabController(vsync: this, length: _allPages.length);

    _loadQuote(null);
    chatTimer = new Timer.periodic(new Duration(seconds: 5), _loadQuote);

  }

  @override
  void dispose() {
    _controller.dispose();
    chatTimer.cancel();
    super.dispose();
  }


  Decoration getIndicator() {

      return const UnderlineTabIndicator();

  }

  @override
  Widget build(BuildContext context) {
    final Color iconColor = Theme.of(context).accentColor;
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('行情'),
        bottom: new TabBar(
          controller: _controller,
          isScrollable: true,
          indicator: getIndicator(),
          tabs: _allPages.map((_Page page) {
                return new Tab(text: page.text);
          }).toList(),
        ),
      ),
      body: new TabBarView(
        controller: _controller,
        children: _allPages.map((_Page page) {
          return new SafeArea(
            top: false,
            bottom: false,
            child: new Container(
              key: new ObjectKey(page.icon),
              padding: const EdgeInsets.all(12.0),
              child:_quoteList!=null?
              new GridView.count(
                crossAxisCount: (3),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 4.0,
                padding: const EdgeInsets.all(4.0),
                childAspectRatio: ( 1.0),
                children:_quoteList.map((Quote quote) =>

                      QutoeCard(quote,vsync: this,),

                ).toList() ,
              ):Text("...")
              ,
            ),
          );
        }).toList()
      ),
    );
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
