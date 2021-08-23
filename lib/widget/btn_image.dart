import 'dart:math';

import 'package:flutter/material.dart';

class TextInImage extends StatelessWidget {
  const TextInImage({
    Key? key,
    required this.minSize,
    required this.posX,
    required this.posY,
    required this.angle,
    required this.text,
    required this.fontSize,
    required this.colorBgBtn,
  }) : super(key: key);

  final double minSize;
  final double posX;
  final double posY;
  final double angle;
  final String text;
  final double fontSize;
  final Color colorBgBtn;
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
        fontSize: fontSize, backgroundColor: colorBgBtn, color: Colors.white);

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
