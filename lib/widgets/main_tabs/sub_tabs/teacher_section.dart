import 'package:flutter/material.dart';
import 'package:flutter_xftz/model/price_quote.dart';
import 'package:flutter_xftz/widgets/main_tabs/sub_tabs/teacher_card.dart';


class TeacherCardSection extends StatelessWidget {

  final List<Quote> _quote;

  TeacherCardSection(this._quote);

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text("Cast", style: new TextStyle(color: Colors.white),),
        new Container(height: 8.0,),
        new Container(
          height: 140.0,
          child: new ListView(
            scrollDirection: Axis.horizontal,
            children: _quote.map((Quote quote) =>
            new Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: new TeacherCard(quote),
            )
            ).toList(),
          ),
        )
      ],
    );
  }

}
