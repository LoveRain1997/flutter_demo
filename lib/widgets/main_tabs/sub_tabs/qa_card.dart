import 'package:flutter/material.dart';
import 'package:flutter_xftz/model/news_live.dart';

class QACard extends StatelessWidget {
  QACard(this.movie);

  final NewsLive movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      child: new Card(
        child: new InkWell(
            onTap: () => print("1"),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      new Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                                "http://roadshow.xftz.cn/images/uploads/fxs/zhouhaozhe.jpg"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[Text("老师"), Text("分析师")],
                        ),
                      ),
                      Text("3小时前")
                    ],

                  ),
                  Text("白银反弹3685附近轻仓进空， 止盈3665， 止损3700；\n白银反弹3685附近轻仓进空， 止盈3665， 止损3700；")
                ],
              ),
            )),
      ),
    );
  }
}
