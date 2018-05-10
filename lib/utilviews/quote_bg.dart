import 'package:flutter/material.dart';


import 'package:flutter/material.dart';



class _BottomGradientState extends State<QuoteGradient> {
  @override
  Widget build(BuildContext context) {

    if (widget.isShow) {
      widget.controller.forward();
    } else {
      widget.controller.reverse();
    }
    //todo 需要更平滑的切换动画
    return !widget.isShow?DecoratedBox(decoration:BoxDecoration(color:Color(0x88E3F2FD)) ):
    FadeTransition(
      opacity: widget.animation,
      child:   new DecoratedBox(
        decoration: new BoxDecoration(
            color:widget.isUp?Color(0x88FFEBEE):Color(0x88E8F5E9)
        ),
      ),
    )
    ;
  }
}


class QuoteGradient extends StatefulWidget {

  @override
  _BottomGradientState createState() => new _BottomGradientState();

  TickerProvider vsync;
  AnimationController controller;
  CurvedAnimation animation;



  bool isUp;
  bool isShow;
  QuoteGradient( this.vsync,this.isUp,this.isShow){
    this.controller = new AnimationController(
      duration: kThemeAnimationDuration,
      vsync: vsync,
    );
    this.animation = new CurvedAnimation(
      parent: this.controller,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
  }



}

