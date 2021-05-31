import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Result {
  bool indicator;
  String message;
  Result(this.indicator, this.message);
}

Widget checkIcon(context) {
  return Container(
    height: 32,
    width: 32,
    child: Icon(
      Icons.check,
      color: Colors.white,
    ),
    decoration: BoxDecoration(color: Colors.lightGreen, shape: BoxShape.circle),
  );
}

Duration durationDefault = Duration(milliseconds: 100);
Cubic curveDefaults = Curves.easeInOut;
