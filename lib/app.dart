import 'package:flutter/material.dart';
import 'package:flutter_xftz/widgets/home_page.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_xftz/scoped_models/app_model.dart';


class XFHJApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
       return ScopedModelDescendant<AppModel>(
         builder: (context,child,model)=> MaterialApp (
           title: 'Cinematic',
           theme: model.theme,
           home: new HomePage(),
         ),
       );
  }

}