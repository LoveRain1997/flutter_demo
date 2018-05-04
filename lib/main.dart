import 'package:flutter/material.dart';
import 'package:flutter_xftz/scoped_models/app_model.dart';
import 'package:flutter_xftz/app.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  runApp(new ScopedModel<AppModel>(
      model: new AppModel(sharedPreferences), child: new XFHJApp()));

}