import 'package:flutter_xftz/utils/utils.dart';

class NewsLive {

   String name;
   String context;

   NewsLive.fromJson(Map jsonMap)
       :name = jsonMap['name'],context = jsonMap['context'];
}


class NewsPingLun {

   String name;
   String context;

   NewsPingLun.fromJson(Map jsonMap)
       :name = jsonMap['name'],context = jsonMap['context'];
}
