import 'package:flutter/material.dart';
import 'package:flutter_xftz/model/people.dart';
import 'package:flutter_xftz/utils/styles.dart';
import 'package:flutter_xftz/utilviews/bottom_gradient.dart';



class TeacherCard extends StatelessWidget {

  final double height;
  final double width;
  final Teacher actor;

  TeacherCard(this.actor, {this.height: 60.0, this.width: 100.0});

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () => print("Teacher"),
      child: new Container(
        height: height,
        width: width,
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Hero(
              tag: 'Cast1-Hero-${actor.name}',
              child: new FadeInImage.assetNetwork(
                placeholder: 'assets/placeholder.jpg',
                image: actor.context ,
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
                  new Text(actor.name, style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 10.0),),
                  new Container(height: 4.0,),
                  new Row(
                    children: <Widget>[
                      new Expanded(child: new Icon(
                        Icons.person, color: salmon, size: 10.0,)),
                      new Container(width: 4.0,),
                      new Expanded(
                        flex: 8,
                        child: new Text(actor.name, softWrap: true,
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