import 'package:flutter/material.dart';

abstract class MainTab {
  MainTab({
    Widget icon,
    String title,
    TickerProvider vsync,
  })  : this.icon = icon,
        this.title = title,
        this.item = new BottomNavigationBarItem(
          icon: icon,
          title: new Text(title),
        ),
        this.controller = new AnimationController(
          duration: kThemeAnimationDuration,
          vsync: vsync,
        ) {
    this.animation = new CurvedAnimation(
      parent: this.controller,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
  }

  final Widget icon;
  final String title;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  CurvedAnimation animation;
  FadeTransition transition(BuildContext context);
}
