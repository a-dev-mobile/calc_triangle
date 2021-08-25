// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:math';

import 'package:calc_triangle/controllers/r_triangle_controller.dart';
import 'package:calc_triangle/utils/key_symbol.dart';
import 'package:calc_triangle/widget/text_widget.dart';
import 'package:calc_triangle/utils/calculator_key.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';

import '../../const.dart';

enum RightTriangelElement {
  aCathet,
  bCathet,
  cHypotenuse,
  aAngle,
  bAngle,
}

class TextSupport {
  const TextSupport({
    required this.posX,
    required this.posY,
    required this.elementFigure,
    required this.angle,
  });

  final double angle;
  final Enum elementFigure;
  final double posX;
  final double posY;
}

class RighTrianglePage extends StatelessWidget {
  const RighTrianglePage({Key? key}) : super(key: key);

  static const maxSelected = 2;
  static const startElement = RightTriangelElement.aCathet;
  static const startValue = '000';
  static List<TextSupport> textSupportList = const [
    TextSupport(
      posX: -5.396,
      posY: 19.117,
      elementFigure: RightTriangelElement.aAngle,
      angle: -67.66,
    ),
    TextSupport(
      posX: -18.073,
      posY: 7.915,
      elementFigure: RightTriangelElement.bAngle,
      angle: -22.96,
    ),
    TextSupport(
      posX: 4.166,
      posY: -4.166,
      elementFigure: RightTriangelElement.cHypotenuse,
      angle: 45,
    ),
    TextSupport(
      posX: 0,
      posY: 43.345,
      elementFigure: RightTriangelElement.aCathet,
      angle: 0,
    ),
    TextSupport(
      posX: -42.845,
      posY: 0,
      elementFigure: RightTriangelElement.bCathet,
      angle: -90,
    )
  ];

  @override
  Widget build(BuildContext context) {
    print('build stack');

    var size = MediaQuery.of(context).size;
    var w = size.width;
    var h = size.height;
    print('w $w h $h');

    final List<Widget> widgetList = textSupportList
        .map((e) => TextWidget(
              posX: e.posX,
              posY: e.posY,
              angle: e.angle,
              elementFigure: e.elementFigure,
            ))
        .toList();

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

            GetStorage().write(ConstGet.minSize, minSize);

            print('1wStack $wStack hStack $hStack');
            print('1minSize $minSize');

            return Stack(
              alignment: Alignment.center,
              children: [
                SizedBox.expand(
                  child: Image(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/image/triangle/4_6.png'),
                  ),
                ),
                //all widget text in image
                for (var item in widgetList) item,
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

  void clickNext() {}

  void clickPrev() {}

  @override
  Widget build(BuildContext context) {
    RtriangleController c = Get.find();

    return Expanded(
      child: TextButton(
        onPressed: () {
          print(symbol.value);

          if (symbol == Keys.next) {
            print('1next');
            c.nextElement();
            print('2next');
          } else if (symbol == Keys.prev) {
            print('1prev');
            clickPrev();
            print('2prev');
          } else {
            c.addKey(symbol);
          }
        },
        child: Text(symbol.value, style: textStyle),
      ),
    );
  }
}
