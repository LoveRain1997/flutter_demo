import 'package:flutter/material.dart';
import 'package:flutter_xftz/model/news_live.dart';
import 'package:flutter_xftz/widgets/main_tabs/sub_tabs/live_news_card.dart';
import 'package:flutter_xftz/widgets/main_tabs/sub_tabs/quote_card.dart';


class NewsLiveSection extends StatelessWidget {

  final List<NewsLive> _newsLive;

  NewsLiveSection(this._newsLive,);

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
          Text("实时资讯", ),
          Container(height: 8.0,),
          Container(
          height: 140.0,
          child:   ListView(
            scrollDirection: Axis.vertical,
            children: _newsLive.map((NewsLive news) =>
              Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child:   NewsLiveCard(news,),
            )
            ).toList(),
          ),
        )
      ],
    );
  }

}
