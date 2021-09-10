// ignore_for_file: avoid_print

import 'dart:math';

import 'package:calc_triangle/app/controller/calculate/right_triangle_c.dart';
import 'package:calc_triangle/app/ui/theme/app_style.dart';
import 'package:calc_triangle/app/utils/app_utils.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ChypotenuseWidget extends StatelessWidget {
  const ChypotenuseWidget(
      {Key? key, required this.posX, required this.posY, required this.angle})
      : super(key: key);

  final double posX;
  final double posY;
  final double angle;

  @override
  Widget build(BuildContext context) {
    RightTriangleController c = Get.find();

    double minSize = AppUtils.getImageMinSize();
    TextStyle styleText;
    bool isActiveInput;
    bool isActiveParam;
    return Transform.translate(
        offset: Offset((posX / 100) * minSize, (posY / 100) * minSize),
        child: Transform.rotate(
          angle: angle * pi / 180,
          child: Obx(() {
            isActiveInput = c.iscHypotenuse.value;
            isActiveParam =
                c.activeParamMap.value.containsValue(RightTriangle.cHypotenuse);

            if (isActiveInput) {
              styleText = AppStyleTextImage.activeInput(context);
            } else if (isActiveParam) {
              styleText = AppStyleTextImage.activeParam(context);
            } else {
              styleText = AppStyleTextImage.inActive(context);
            }
            return Text(
              c.cHypotenuse.value,
              style: styleText,
            );
          }),
        ));
  }
}
