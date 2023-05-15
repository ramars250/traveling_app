import 'package:flutter/material.dart';

class Stroke {
  final path = Path();
  Color color;
  double width;

  Stroke({
    this.color = Colors.black,
    this.width = 3,
  });
}
