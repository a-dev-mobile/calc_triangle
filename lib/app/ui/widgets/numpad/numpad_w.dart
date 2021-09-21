import 'package:calc_triangle/app/controller/calculate/right_triangle_c.dart';
import 'package:calc_triangle/app/controller/select_shape/select_shape_c.dart';
import 'package:calc_triangle/app/ui/theme/app_style.dart';
import 'package:calc_triangle/app/ui/widgets/numpad/key.dart';

import 'package:calc_triangle/app/ui/widgets/numpad/key_symbol.dart';
import 'package:flutter/material.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';

late RightTriangleController rightTriangleController = Get.find();
late SelectShapeController selectTriangleController = Get.find();

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
              Obx(() {
                return CalculatorKey(
                    symbol: rightTriangleController.isDeg.value
                        ? Keys.deg
                        : Keys.degMinSec);
              }),
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
          if (symbol == Keys.backspace) {
            rightTriangleController.longBackspace();
          }
        },
        onPressed: () {
          // printt.v(symbol.value);
          rightTriangleController.clickKey(symbol);
        },
        child: Text(symbol.value, style: textStyle),
      ),
    );
  }
}
