import 'package:flutter/material.dart';
import 'package:flutter_xftz/widgets/main_tabs/main_tab_super.dart';


class TabIndexPage   extends MainTab  {

  TabIndexPage(   {
    this.subTabPages,
    Widget icon,
    String title,
    TickerProvider vsync,
  }):super( icon:icon,title:title ,vsync:vsync);

  List<Widget> subTabPages;

  FadeTransition transition(BuildContext context) {
    Color iconColor;

    final ThemeData themeData = Theme.of(context);
    iconColor = themeData.brightness == Brightness.light
        ? themeData.primaryColor
        : themeData.accentColor;


    return new FadeTransition(
      key: ObjectKey(title),
      opacity:  animation,
      child: new SlideTransition(
        position: new Tween<Offset>(
          begin: const Offset(0.0, 0.02), // Slightly down.
          end: Offset.zero,
        ).animate( animation),
        child: new TabBarView(
          children: subTabPages,
        ) ,
      ),
    );
  }




}
