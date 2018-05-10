import 'package:flutter/material.dart';
import 'package:flutter_xftz/model/news_live.dart';


class PingLunCard extends StatelessWidget {
  PingLunCard(this.movie);

  final NewsLive movie;

  Widget _getTitleSection(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(12.0),
      child: new Row(
        children: [
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  child: new Text(
                   "伊核协议彻底破裂 ",
                    style: Theme
                        .of(context)
                        .textTheme
                        .subhead
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                new Container(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: new Text(
                    "特朗普宣布退出核协议并决定",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.body1,
                  ),
                )
              ],
            ),
          ),
          new Container(
            width: 12.0,
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Text(
                    "葛英奇",
                    style: Theme.of(context).textTheme.body1,
                  ),
                  new Container(
                    width: 4.0,
                  ),
                  new Icon(
                    Icons.star,
                    size: 16.0,
                  )
                ],
              ),
              new Container(
                height: 4.0,
              ),
              new Row(
                children: <Widget>[
                  new Text(
                   "2018-05-10 16:34",
                    style: Theme.of(context).textTheme.body1,
                  ),
                  new Container(
                    width: 4.0,
                  ),
                  new Icon(
                    Icons.date_range,
                    size: 16.0,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new InkWell(
        onTap: () => print("1"),
        child: new Column(
          children: <Widget>[
            new Hero(
              child: new FadeInImage.assetNetwork(
                placeholder: "assets/placeholder.jpg",
                image: "http://www.xftz.cn/uploads/allimg/180510/25292-1P51016344O41.jpg",
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200.0,
                fadeInDuration: new Duration(milliseconds: 50),
              ),
              tag: "Movie-Tag-${movie.name}",
            ),
            _getTitleSection(context),
          ],
        ),
      ),
    );
  }
}
