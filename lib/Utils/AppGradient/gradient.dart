import 'package:flutter/material.dart';

Widget gradient(
    {required Widget child,
    double topRightRadius = 0,
    double bottomRightRadius = 0,
    double topleftRadius = 0,
    double bottomLeftRadius = 0,
    double transform = 2.5}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(topRightRadius),
        bottomLeft: Radius.circular(bottomLeftRadius),
        topLeft: Radius.circular(topleftRadius),
        bottomRight: Radius.circular(bottomRightRadius),
      ),
      gradient: LinearGradient(colors: [
        Color(0xff4E4FA2),
        Color(0xff3F74BA),
      ], transform: GradientRotation(transform)),
    ),
    child: child,
  );
}

Widget gradientCircle({required Widget child, double transform = 2.5}) {
  return Container(
    padding: EdgeInsets.all(2),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(colors: [
        Color(0xff4E4FA2),
        Color(0xff3F74BA),
      ], transform: GradientRotation(transform)),
    ),
    child: child,
  );
}
