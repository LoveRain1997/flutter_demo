import 'package:flutter/material.dart';
import 'package:flutter_xftz/model/price_quote.dart';
import 'package:flutter_xftz/utilviews/bottom_gradient.dart';

class QutoeCard extends StatelessWidget {
  final double height;
  final double width;
  final Quote quote;

  QutoeCard(this.quote, {this.height: 140.0, this.width: 100.0});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    bool isShowChange ;

    return new GestureDetector(
      onTap: () => print("QuoteCard"),
      child: new Container(
        height: height,
        width: width,
        decoration: new BoxDecoration(color:themeData.backgroundColor),
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Hero(
              tag: 'Cast-Hero-${quote.id}',
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(quote.ProductCode,style: TextStyle(fontSize: 16.0,fontWeight:  FontWeight.w400 ),),
                  Text(quote.Ask.toString(),style: TextStyle(fontSize: 18.0,fontWeight:  FontWeight.w500),)
                ],
              ),
            ),
            new BottomGradient.noOffset(),
            new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(quote.UpsAndDowns>0?Icons.arrow_drop_up,color: ,),
                  new Text(
                    quote.UpsAndDowns.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 10.0),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
