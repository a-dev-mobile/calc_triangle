// ignore_for_file: avoid_print

import 'dart:math';

import 'package:calc_triangle/controllers/r_triangle_controller.dart';
import 'package:calc_triangle/pages/r_triangle_page.dart';
import 'package:calc_triangle/pages/test_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../const.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.posX,
    required this.posY,
    required this.angle,
    required this.elementFigure,

    // required this.rightTriangelInput,
  }) : super(key: key);

  final double posX;
  final double posY;
  final double angle;

  final Enum elementFigure;

  @override
  Widget build(BuildContext context) {
    RtriangleController c = Get.find();
    double minSize = GetStorage().read(ConstGet.minSize);
    Color colorText;
    print('build text  $minSize');
    print('build text element $elementFigure');

    return Transform.translate(
        offset: Offset((posX / 100) * minSize, (posY / 100) * minSize),
        child: Transform.rotate(
          angle: angle * pi / 180,
          child: Obx(() {
            print('obs text');
            print(c.selectedElement.value);
            String inputSymbols = c.inputSymbols.value;
            elementFigure == c.selectedElement.value
                ? colorText = Colors.red
                : colorText = Colors.white;
            //стартовое значение
            if (inputSymbols.isEmpty) {
              inputSymbols = RighTrianglePage.startValue;
            }
            return Text(
              inputSymbols,
              style: TextStyle(
                  backgroundColor: ConstColors.scaffoldBackground,
                  fontSize: 50.sp,
                  color: colorText),
            );
          }),
        ));
  }
}
