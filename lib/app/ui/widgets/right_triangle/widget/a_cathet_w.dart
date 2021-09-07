// ignore_for_file: avoid_print

import 'package:calc_triangle/app/controller/calculate/right_triangle_c.dart';
import 'package:calc_triangle/app/ui/theme/app_style.dart';
import 'package:calc_triangle/app/ui/theme/app_utils.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AcathetWidget extends StatelessWidget {
  const AcathetWidget(
      {Key? key, required this.posX, required this.posY, required this.angle})
      : super(key: key);

  final double posX;
  final double posY;
  final double angle;
  @override
  Widget build(BuildContext context) {
    RightTriangleController c = Get.find();

    double minSize = AppUtils.getImageMinSize();

    return Transform.translate(
        offset: Offset((posX / 100) * minSize, (posY / 100) * minSize),
        child: Obx(() {
          TextStyle styleText;
          if (c.isAcathet.value) {
            styleText = AppStyleTextImage.active(context);
          } else {
            styleText = AppStyleTextImage.inActive(context);
          }

          print('obx aCathet');
          return Text(
            c.aCathet.toString(),
            style: styleText,
          );
        }));
  }
}
