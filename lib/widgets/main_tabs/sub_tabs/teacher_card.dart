import 'package:flutter/material.dart';
import 'package:flutter_xftz/model/price_quote.dart';
import 'package:flutter_xftz/utilviews/bottom_gradient.dart';



class TeacherCard extends StatelessWidget {

  final double height;
  final double width;
  final Quote quote;

  TeacherCard(this.quote, {this.height: 140.0, this.width: 100.0});

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () => print("QuoteCard"),
      child: new Container(
        height: height,
        width: width,
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Hero(
              tag: 'Cast-Hero-${quote.id}',
              child: new FadeInImage.assetNetwork(
                placeholder: 'assets/placeholder.jpg',
                image: quote.ProductName,
                fit: BoxFit.cover,
                height: height,
                width: width,
              ),
            ),
            new BottomGradient.noOffset(),
            new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(quote.ProductName, style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 10.0),),
                  new Container(height: 4.0,),
                  new Row(
                    children: <Widget>[
                      new Expanded(child: new Icon(
                        Icons.person, color: Colors.deepOrange, size: 10.0,)),
                      new Container(width: 4.0,),
                      new Expanded(
                        flex: 8,
                        child: new Text(quote.ProductName, softWrap: true,
                            overflow: TextOverflow.ellipsis, maxLines: 2,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 8.0)
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}