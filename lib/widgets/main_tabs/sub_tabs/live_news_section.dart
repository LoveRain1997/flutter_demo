import 'package:flutter/material.dart';
import 'package:flutter_xftz/model/news_live.dart';
import 'package:flutter_xftz/widgets/main_tabs/sub_tabs/live_news_card.dart';
import 'package:flutter_xftz/widgets/main_tabs/sub_tabs/quote_card.dart';


class NewsLiveSection extends StatelessWidget {

  final List<NewsLive> _newsLive;

  final String title;

  NewsLiveSection(this._newsLive,this.title);

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
          Text(this.title, ),
          Container(height: 8.0,),
             Column(
            children: _newsLive.map((NewsLive news) =>
            NewsLiveCard(news,)

            ).toList(),
          ),
      ],
    );
  }

}
