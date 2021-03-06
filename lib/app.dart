import 'package:flutter/material.dart';
import 'package:flutter_xftz/utils/item.dart';
import 'package:flutter_xftz/widgets/home_page.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_xftz/scoped_models/app_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class XFHJApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Map<String, WidgetBuilder> _kRoutes = <String, WidgetBuilder>{};
    for (GalleryItem item in kAllGalleryItems) {
      _kRoutes[item.routeName] = (BuildContext context) {
        return item.buildRoute(context);
      };
    }

       return ScopedModelDescendant<AppModel>(
         builder: (context,child,model)=> MaterialApp (
           localizationsDelegates: [
             // ... app-specific localization delegate[s] here
             GlobalMaterialLocalizations.delegate,
             GlobalWidgetsLocalizations.delegate,
           ],
           supportedLocales: [
             const Locale('zh', 'CN'), // English
             // ... other locales the app supports
           ],
           title: 'Cinematic',
           theme: model.theme,
           routes: _kRoutes,
           home: new HomePage(),
         ),
       );
  }

}