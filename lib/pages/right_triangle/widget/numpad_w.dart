import 'package:calc_triangle/controllers/r_triangle_c.dart';
import 'package:calc_triangle/utils/calculator_key.dart';
import 'package:calc_triangle/utils/key_symbol.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../right_triangle_p.dart';

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
          color: Color(0x80A94963),
          fontSize: 80.sp,
        );

      case KeyType.operator:
        return TextStyle(
          color: const Color(0x8083BFFF),
          fontSize: 150.sp,
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
