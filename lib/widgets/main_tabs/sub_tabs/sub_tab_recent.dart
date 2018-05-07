
 import 'package:flutter/material.dart';
import 'package:flutter_xftz/utilviews/indicator_viewpager.dart';

 const double _kAppBarHeight = 200.0;

 class SubTabRecentPage extends StatefulWidget {
   @override
   _SubTabRecentPageState createState() => new _SubTabRecentPageState();
 }

 class _SubTabRecentPageState extends State<SubTabRecentPage> {
   List<Widget> _imagePages;

   List<String> _urls = [
     'https://imgsa.baidu.com/news/q%3D100/sign=dbc6207d9e45d688a502b6a494c37dab/b64543a98226cffc062c56fcb5014a90f603ea7e.jpg',
     'https://imgsa.baidu.com/news/q%3D100/sign=11f1fc6819ce36d3a40487300af23a24/e4dde71190ef76c6edabfb999116fdfaaf516702.jpg',
     'https://imgsa.baidu.com/news/q%3D100/sign=b060b3916f2762d0863ea0bf90ed0849/b7003af33a87e9502ca6ffde1c385343faf2b4ca.jpg'
   ];

   @override
   void initState() {
     super.initState();
     if (!_urls.isEmpty) {
       _imagePages = <Widget>[];
       _urls.forEach((String url) {
         _imagePages.add(
             new Container(
                 color: Colors.black.withAlpha(900),
                 child: new ConstrainedBox(
                   constraints: const BoxConstraints.expand(),
                   child: new Image.network(
                     url,
                     fit: BoxFit.cover,
                     height: _kAppBarHeight,
                   ),
                 ))
         );
       });
     }

   }

   @override
   Widget build(BuildContext context) {



     return  new Column(
       children: <Widget>[
         new SizedBox.fromSize(
           size: const Size.fromHeight(_kAppBarHeight),
           child:   IndicatorViewPager(_imagePages),
         )
       ],

     );
   }
 }
