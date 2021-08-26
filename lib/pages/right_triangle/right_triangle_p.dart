// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:math';

import 'package:calc_triangle/controllers/r_triangle_c.dart';
import 'package:calc_triangle/pages/right_triangle/widget/a_angle_w.dart';
import 'package:calc_triangle/pages/right_triangle/widget/a_cathet_w.dart';
import 'package:calc_triangle/pages/right_triangle/widget/b_angle.dart';
import 'package:calc_triangle/pages/right_triangle/widget/b_cathet_w.dart';
import 'package:calc_triangle/pages/right_triangle/widget/c_hypotenusea_w.dart';
import 'package:calc_triangle/pages/right_triangle/widget/image_info_w.dart';
import 'package:calc_triangle/utils/key_symbol.dart';

import 'package:calc_triangle/utils/calculator_key.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';

import '../../../const.dart';
import 'widget/image_input_w.dart';

enum RightTriangelElement {
  aCathet,
  bCathet,
  cHypotenuse,
  aAngle,
  bAngle,
}

class RighTrianglePage extends StatelessWidget {
  const RighTrianglePage({Key? key}) : super(key: key);

  static const maxSelected = 2;
  static const maxValue = 5;

  static const startElement = RightTriangelElement.aCathet;
  static const startValue = '000';

  @override
  Widget build(BuildContext context) {
    RtriangleController c = Get.find();
    print('build stack');

    var size = MediaQuery.of(context).size;
    var w = size.width;
    var h = size.height;
    print('w $w h $h');

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Obx(() {
            if (c.isInputImage.value) {
              return ImageInputWidget();
            } else {
              return ImageInfoWidget();
            }
          }),
          Placeholder(
            fallbackWidth: 1.sw,
            fallbackHeight: 0.2.sh,
            color: Colors.amber,
          ),
          Expanded(
            child: NumPad(),
          ),
        ],
      ),
    ));
  }
}

class NumPad extends StatelessWidget {
  const NumPad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CalculatorKey(symbol: Keys.seven),
              CalculatorKey(symbol: Keys.eight),
              CalculatorKey(symbol: Keys.nine),
              CalculatorKey(symbol: Keys.backspase),
            ],
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CalculatorKey(symbol: Keys.four),
              CalculatorKey(symbol: Keys.five),
              CalculatorKey(symbol: Keys.six),
              CalculatorKey(symbol: Keys.next),
            ],
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CalculatorKey(symbol: Keys.one),
              CalculatorKey(symbol: Keys.two),
              CalculatorKey(symbol: Keys.three),
              CalculatorKey(symbol: Keys.prev),
            ],
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CalculatorKey(symbol: Keys.clear),
              CalculatorKey(symbol: Keys.zero),
              CalculatorKey(symbol: Keys.decimal),
              CalculatorKey(symbol: Keys.toggleImage),
            ],
          ),
        ),
      ],
    );
  }
}

class CalculatorKey extends StatelessWidget {
  const CalculatorKey({
    Key? key,
    required this.symbol,
  }) : super(key: key);

  final KeySymbol symbol;

  TextStyle get textStyle {
    switch (symbol.type) {
      case KeyType.function:
        return TextStyle(
          color: Colors.green,
          fontSize: 100.sp,
        );

      case KeyType.operator:
        return TextStyle(
          color: Colors.amber,
          fontSize: 110.sp,
        );

      case KeyType.integer:
      default:
        return TextStyle(
          color: Colors.white,
          fontSize: 90.sp,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    RtriangleController c = Get.find();

    return Expanded(
      child: TextButton(
        onPressed: () {
          print(symbol.value);

          if (symbol == Keys.next) {
            c.nextElement();
          } else if (symbol == Keys.prev) {
            c.prevElement();
          } else if (symbol == Keys.clear) {
            c.clear();
          } else if (symbol == Keys.backspase) {
            c.backspase();
          } else if (symbol == Keys.toggleImage) {
            c.isInputImage.value = !c.isInputImage.value;
          } else {
            c.addKey(symbol);
          }
        },
        child: Text(symbol.value, style: textStyle),
      ),
    );
  }
}
