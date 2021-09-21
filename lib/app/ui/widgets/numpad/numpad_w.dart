import 'package:calc_triangle/app/controller/calculate/right_triangle_c.dart';
import 'package:calc_triangle/app/controller/calculate/scalene_triangle_c.dart';
import 'package:calc_triangle/app/controller/select_shape/select_shape_c.dart';
import 'package:calc_triangle/app/ui/theme/app_style.dart';
import 'package:calc_triangle/app/ui/widgets/numpad/key.dart';

import 'package:calc_triangle/app/ui/widgets/numpad/key_symbol.dart';
import 'package:calc_triangle/main.dart';
import 'package:flutter/material.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';

late RightTriangleController rightTriangleController =
    RightTriangleController.to;
late ScaleneTriangleController scaleneTriangleController =
    ScaleneTriangleController.to;
late SelectShapeController selectTriangleController = Get.find();

var activeShape = selectTriangleController.activeShape;

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
              CalculatorKey(symbol: Keys.backspace),
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
              CalculatorKey(symbol: Keys.clearAll),
              CalculatorKey(symbol: Keys.zero),
              CalculatorKey(symbol: Keys.decimal),
              CalculatorKey(symbol: Keys.deg),
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

  @override
  Widget build(BuildContext context) {
    // printt.i(symbol.value,symbol.type);
    TextStyle textStyle;
    switch (symbol.type) {
      case KeyType.function:
        textStyle = AppStyleNumpad.function(context);
        break;
      case KeyType.choice:
        textStyle = AppStyleNumpad.operator(context);
        break;
      case KeyType.convert:
        textStyle = AppStyleNumpad.convert(context);
        break;
      case KeyType.integer:
      default:
        textStyle = AppStyleNumpad.integer(context);
    }

    return Expanded(
      child: TextButton(
        onLongPress: () {
          if (symbol == Keys.backspace) longPressBackspace();
        },
        onPressed: () {
          onPresed();
        },
        child: Text(symbol.value, style: textStyle),
      ),
    );
  }

  void longPressBackspace() {
    if (activeShape == Shape.rightTriangle) {
      rightTriangleController.longBackspace();
    } else if (activeShape == Shape.scaleneTriangle) {
      scaleneTriangleController.longBackspace();
    }
  }

  void onPresed() {
    printt.i(activeShape);
    if (activeShape == Shape.rightTriangle) {
      rightTriangleController.clickKey(symbol);
    } else if (activeShape == Shape.scaleneTriangle) {
      scaleneTriangleController.clickKey(symbol);
    }
  }
}
