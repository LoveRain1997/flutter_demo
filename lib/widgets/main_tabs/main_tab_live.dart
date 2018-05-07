import 'package:flutter/material.dart';
import 'package:flutter_xftz/widgets/main_tabs/main_tab_super.dart';


class TabLivePage      extends MainTab   {

  TabLivePage({
    Widget icon,
    String title,
    TickerProvider vsync,
  }):super( icon:icon,title:title ,vsync:vsync);

  FadeTransition transition(BuildContext context) {
    Color iconColor;

    final ThemeData themeData = Theme.of(context);
    iconColor = themeData.brightness == Brightness.light
        ? themeData.primaryColor
        : themeData.accentColor;


    return new FadeTransition(
      opacity:  animation,
      child: new SlideTransition(
        position: new Tween<Offset>(
          begin: const Offset(0.0, 0.02), // Slightly down.
          end: Offset.zero,
        ).animate( animation),
        child: new IconTheme(
          data: new IconThemeData(
            color: iconColor,
            size: 120.0,
          ),
          child: new Semantics(
            label: 'Placeholder for $title tab',
            child: icon,
          ),
        ),
      ),
    );
  }

}
