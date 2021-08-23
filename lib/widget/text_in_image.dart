import 'dart:math';

import 'package:flutter/material.dart';

import '../const.dart';

class TextInImage extends StatelessWidget {
  const TextInImage({
    Key? key,
    required this.minSize,
    required this.posX,
    required this.posY,
    required this.angle,
    required this.text,
    required this.fontSize,
    this.isActive = false,
  }) : super(key: key);
  final bool isActive;
  final double minSize;
  final double posX;
  final double posY;
  final double angle;
  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle;
    if (!isActive) {
      textStyle = TextStyle(
          fontSize: fontSize,
          backgroundColor: ConstColors.scaffoldBackground,
          color: Colors.white);
    } else {
      textStyle = TextStyle(
          fontSize: fontSize,
          backgroundColor: ConstColors.scaffoldBackground,
          color: Colors.red);
    }

    return Transform.translate(
      offset: Offset((posX / 100) * minSize, (posY / 100) * minSize),
      child: Transform.rotate(
          angle: angle * pi / 180,
          child: Text(
            text,
            style: textStyle,
          )),
    );
  }
}
