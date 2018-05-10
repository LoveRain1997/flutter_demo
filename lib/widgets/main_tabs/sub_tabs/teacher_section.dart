import 'package:flutter/material.dart';
import 'package:flutter_xftz/model/people.dart';
import 'package:flutter_xftz/widgets/main_tabs/sub_tabs/teacher_card.dart';


class TeacherCardSection extends StatelessWidget {

  final List<Teacher> _cast;

  TeacherCardSection(this._cast);

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(height: 8.0,),
        new Container(
          height: 100.0,
          child: new ListView(
            scrollDirection: Axis.horizontal,
            children: _cast.map((Teacher actor) =>
            new Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: new TeacherCard(actor),
            )
            ).toList(),
          ),
        )
      ],
    );
  }

}
