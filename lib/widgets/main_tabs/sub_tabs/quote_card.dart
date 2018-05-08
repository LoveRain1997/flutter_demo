import 'package:flutter/material.dart';
import 'package:flutter_xftz/model/price_quote.dart';
import 'package:flutter_xftz/utilviews/bottom_gradient.dart';

class QutoeCard extends StatelessWidget {
  final double height;
  final double width;
  final Quote quote;
  CurvedAnimation animation;
  TickerProvider vsync;
  AnimationController controller;

  QutoeCard(this.quote, {this.height: 140.0, this.width: 100.0, this.vsync}) {
    this.controller = new AnimationController(
      duration: kThemeAnimationDuration,
      vsync: vsync,
    );
    this.animation = new CurvedAnimation(
      parent: this.controller,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
  }


  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    bool isShowChanged = quote.UpsAndDowns.abs() > 0.1;

    if (isShowChanged) {
      controller.forward();
    } else {
      controller.reverse();
    }

    return new GestureDetector(
      onTap: () => print("QuoteCard"),
      child: new Container(
        height: height,
        width: width,
        decoration: new BoxDecoration(color: themeData.backgroundColor),
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Hero(
              tag: 'Cast-Hero-${quote.id}',
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    quote.ProductCode,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                  ),
                  new Container(
                    height: 10.0,
                  ),
                  Text(
                    quote.Ask.toString(),
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            new BottomGradient(vsync, quote.UpsAndDowns > 0,isShowChanged),
            FadeTransition(
                opacity: animation,
                child: new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        "",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0),
                      ),
                      new Container(
                        height: 4.0,
                      ),
                      new Row(
                        children: <Widget>[
                          new Expanded(
                              child: new Icon(
                            quote.UpsAndDowns > 0
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down,
                            color: quote.UpsAndDowns > 0
                                ? Colors.red
                                : Colors.green,
                            size: 20.0,
                          )),
                          new Container(
                            width: 2.0,
                          ),
                          new Expanded(
                            flex: 4,
                            child: new Text(quote.UpsAndDowns.toString(),
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 13.0)),
                          ),
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
