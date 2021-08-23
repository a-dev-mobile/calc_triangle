// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:convert';
import 'dart:math';

import 'package:calc_triangle/controllers/r_triangle_controller.dart';
import 'package:calc_triangle/utils/key_symbol.dart';
import 'package:calc_triangle/widget/text_in_image.dart';
import 'package:calc_triangle/utils/calculator_key.dart';
import 'package:calc_triangle/widget/formulas_web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../const.dart';

const List height = [0.4, 0.2];

class RighTriangelePage extends StatelessWidget {
  const RighTriangelePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(RtriangleController());

    var size = MediaQuery.of(context).size;
    var w = size.width;
    var h = size.height;
    print('w $w h $h');

    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 0.4.sh,
          width: 1.sw,
          child: LayoutBuilder(builder: (context, constraints) {
            var wStack = constraints.maxWidth;
            var hStack = constraints.maxHeight;
            var minSize = min(wStack, hStack);
            c.minSize.value = minSize;
            print('1wStack $wStack hStack $hStack');
            print('1minSize $minSize');

            return Stack(
              alignment: Alignment.center,
              children: [
                Transform.rotate(
                  angle: 0,
                  child: SizedBox.expand(
                    child: Image(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/image/triangle/4_6.png'),
                    ),
                  ),
                ),
                TextInImage(
                  minSize: minSize,
                  text: '123.123',
                  angle: -67.66,
                  fontSize: 40.sp,
                  posX: -5.396,
                  posY: 19.117,
                ),
                TextInImage(
                  minSize: minSize,
                  text: '222.222',
                  angle: -22.96,
                  fontSize: 40.sp,
                  posX: -18.073,
                  posY: 7.915,
                ),
                TextInImage(
                  minSize: minSize,
                  text: '233.333',
                  angle: 45,
                  fontSize: 60.sp,
                  posX: 4.166,
                  posY: -4.166,
                ),
                TextInImage(
                  minSize: minSize,
                  text: '4444.4444',
                  angle: 0,
                  fontSize: 60.sp,
                  posX: 0,
                  posY: 43.345,
                  isActive: true,
                ),
                TextInImage(
                  minSize: minSize,
                  text: '111.111',
                  angle: -90,
                  fontSize: 60.sp,
                  posX: -42.845,
                  posY: 0,
                ),
              ],
            );
          }),
        ),
        Placeholder(
          fallbackWidth: 1.sw,
          fallbackHeight: 0.2.sh,
          color: Colors.amber,
        ),
        Expanded(
          child: NumPad(),
        ),
        // SizedBox(
        //   width: 1.sw,
        //   height: 0.2.sh,
        //   child: FormulasWebView(),
        // ),
      ],
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
              CalculatorKey(symbol: Keys.next),
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
              CalculatorKey(symbol: Keys.prev),
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
              CalculatorKey(symbol: Keys.backspase),
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
              CalculatorKey(symbol: Keys.equals),
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
          color: Color.fromARGB(255, 96, 96, 96),
          fontSize: 60.sp,
        );

      case KeyType.operator:
        return TextStyle(
          color: Colors.amber,
          fontSize: 80.sp,
        );

      case KeyType.integer:
      default:
        return TextStyle(
          color: Colors.white,
          fontSize: 80.sp,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          print(symbol.value);
          RtriangleController.to.addKey(symbol);
        },
        child: Text(symbol.value, style: textStyle),
      ),
    );
  }
}
