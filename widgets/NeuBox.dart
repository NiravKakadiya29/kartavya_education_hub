import 'package:flutter/material.dart';

class NeuBox extends StatelessWidget {
  final Widget child;
  final double distance;
  final int bgColor;
  final int topLeft;
  final int bottomRight;
  final double blurRadius;
  final double borderRadius;
  final double width;
  final double height;

  const NeuBox({
    Key? key,
    required this.child,
    required this.distance,
    required this.bgColor,
    required this.topLeft,
    required this.bottomRight,
    required this.blurRadius,
    required this.borderRadius,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(bgColor),
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(bgColor),
            Color(bgColor),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(topLeft),
            offset: Offset(-distance, -distance),
            blurRadius: blurRadius,
            spreadRadius: 0.0,
          ),
          BoxShadow(
            color: Color(bottomRight),
            offset: Offset(distance, distance),
            blurRadius: blurRadius,
            spreadRadius: 0.0,
          ),
        ],
      ),
      width: width,
      height: height,
      child: child,
    );
  }
}
