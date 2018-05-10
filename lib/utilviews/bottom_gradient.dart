import 'package:flutter/material.dart';

class BottomGradient extends StatelessWidget {

  final double offset;

  BottomGradient({this.offset: 0.95});

  BottomGradient.noOffset() : offset = 1.0;

  @override
  Widget build(BuildContext context) {
    return new DecoratedBox(
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
            end: const FractionalOffset(0.0, 0.0),
            begin: new FractionalOffset(0.0, offset),
            colors: const <Color>[
              const Color(0xff222128),
              const Color(0x4490CAF9),
              const Color(0x00E3F2FD)
            ],
          )
      ),
    );
  }
}

