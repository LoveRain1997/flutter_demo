import 'package:flutter/material.dart';

class BottomGradient extends StatelessWidget {


  TickerProvider vsync;
  AnimationController controller;
  CurvedAnimation animation;


  ColorTween _bgColor;

  bool isUp;
  bool isShow;
  BottomGradient( this.vsync,this.isUp,this.isShow){
    this.controller = new AnimationController(
      duration: kThemeAnimationDuration,
      vsync: vsync,
    );
    this.animation = new CurvedAnimation(
      parent: this.controller,
      curve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
    );
  }


  @override
  Widget build(BuildContext context) {
//
//
//    _bgColor
//      ..begin = Color(0x88FFEBEE)
//      ..end =  Colors.green ;
//
//    final Color borderSideColor = _bgColor.evaluate(_easeOutAnimation) ?? Colors.transparent;
//    final Color titleColor = _bgColor.evaluate(_easeInAnimation);
    if (isShow) {
      controller.forward();
    } else {
      controller.reverse();
    }

    return
      FadeTransition(
        opacity: animation,
        child:   new DecoratedBox(
          decoration: new BoxDecoration(
              color: isUp?Color(0x88FFEBEE):Color(0x88E8F5E9)
          ),
        ),
      )
    ;
  }
}

