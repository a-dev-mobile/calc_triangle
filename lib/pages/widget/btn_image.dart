import 'dart:math';

import 'package:flutter/material.dart';

class BtnImage extends StatelessWidget {
  const BtnImage({
    Key? key,
    required this.minSize,
    required this.posX,
    required this.posY,
    required this.angle,
    required this.text,
    required this.fontSize,
    required this.colorTextBtn,
    required this.colorBgBtn,
  }) : super(key: key);

  final double minSize;
  final double posX;
  final double posY;
  final double angle;
  final String text;
  final double fontSize;
  final Color colorTextBtn;
  final Color colorBgBtn;
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset((posX / 100) * minSize, (posY / 100) * minSize),
      child: Transform.rotate(
        angle: angle * pi / 180,
        child: TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size.zero, // <-- Add this
            padding: EdgeInsets.zero, // <-- and this
            elevation: 0,
            backgroundColor: colorBgBtn,
          ),
          onPressed: () {
            print('click');
          },
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize, color: colorTextBtn),
          ),
        ),
      ),
    );
  }
}
