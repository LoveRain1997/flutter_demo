import 'package:flutter/material.dart';
import 'package:flutter_xftz/model/news_live.dart';

class NewsLiveCard extends StatefulWidget {
  final double height;
  final double width;
  final NewsLive news;

  NewsLiveCard(this.news, {this.height: 140.0, this.width: 100.0,}) {

  }

  @override
  _NewsLiveCardState createState() => new _NewsLiveCardState();
}

class _NewsLiveCardState extends State<NewsLiveCard> {
  @override
  Widget build(BuildContext context) {
    return Text("NewsLiveCard")  ;
  }
}
