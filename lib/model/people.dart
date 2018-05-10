import 'package:flutter_xftz/utils/utils.dart';

class Teacher {

  String name;
  String context;

  Teacher({this.name="老师", this.context="http://roadshow.xftz.cn/images/uploads/fxs/chenzhen.jpg"});

  Teacher.fromJson(Map jsonMap)
      :name = jsonMap['name'],context = jsonMap['context'];
}
