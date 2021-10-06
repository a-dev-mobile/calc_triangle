import 'package:calc_triangle/app/config/theme/app_style.dart';

import 'package:calc_triangle/app/features/calculate/controllers/isosceles_c.dart';
import 'package:calc_triangle/app/shared_components/numpad/key.dart';
import 'package:calc_triangle/app/shared_components/numpad/key_symbol.dart';

import 'package:flutter/material.dart';

var c = IsoscelesTriangleController.to;

class NumPadIsoscelesWidget extends StatelessWidget {
  const NumPadIsoscelesWidget({Key? key}) : super(key: key);

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
          if (symbol == Keys.backspace) {
            c.longBackspace();
          }
        },
        onPressed: () {
          c.clickKey(symbol);
        },
        child: Text(symbol.value, style: textStyle),
      ),
    );
  }
}
