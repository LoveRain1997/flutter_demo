import 'package:flutter/material.dart';
import 'package:flutter_xftz/model/news_live.dart';

class NewsLiveCard extends StatefulWidget {
  final double height;
  final double width;
  final NewsLive news;

  NewsLiveCard(
    this.news, {
    this.height: 110.0,
    this.width: 100.0,
  }) {}

  @override
  _NewsLiveCardState createState() => new _NewsLiveCardState();
}

class _NewsLiveCardState extends State<NewsLiveCard> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: widget.height,

        child:
        Container(
          height: widget.height-20,

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new GestureDetector(
                onTap: () => print(widget.news.name),
                child: new FadeInImage.assetNetwork(
                  image: "http://www.xftz.cn/uploads/allimg/180509/3047-1P509195S40-L.png",
                  placeholder: 'assets/placeholder.jpg',
                  height: widget.height-20,
                  width: widget.height-20,
                  fit: BoxFit.cover,
                ),
              ),
              new Container(
                width: 10.0,
              ),
              Expanded(
                child:new Container(
                  decoration: new BoxDecoration(border: Border(bottom: BorderSide(width:0.5,color:Theme.of(context).dividerColor))),
                  margin: EdgeInsets.only(top: 10.0,bottom: 10.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                          new Container(
                            child: new Text(
                              "元终止三日连涨元终止三日连涨元终止三日连涨",
                              maxLines: 2,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .body1
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ) ,



                          new Container(
                            margin: const EdgeInsets.only(top: 4.0),
                            child: new Text(
                              " 现货黄金周三(5月9日)亚市早盘开于1314.40美元/盎司，最低下探1304.11美元/盎司，最高上涨至1317.40美元/盎司，5月9日)亚市早盘开于1314.40美元/盎司，最低下探1304.11美元/盎司，最高上涨至1317.40美元/盎司，.40美元/盎司，下跌1.68美元，跌幅0.13%。",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          )
,
                          new Expanded(
                            child: new Container(),
                          ),
                      new Container(
                        child: new Text(
                          "2018-05-10 09:01",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      )
                    ],
                  ),
                ) ,
              )


            ],
          ) ,) ,
        )

      ;
  }
}
