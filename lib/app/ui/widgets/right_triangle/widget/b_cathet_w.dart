import 'dart:math';

import 'package:calc_triangle/app/controller/calculate/calculate_c.dart';
import 'package:calc_triangle/app/ui/theme/app_style.dart';
import 'package:calc_triangle/app/ui/theme/app_utils.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

class BcathetWidget extends StatelessWidget {
  const BcathetWidget(
      {Key? key, required this.posX, required this.posY, required this.angle})
      : super(key: key);

  final double posX;
  final double posY;
  final double angle;
  @override
  Widget build(BuildContext context) {
    CalculateController c = Get.find();

    double minSize = AppUtils.getImageMinSize();

    return Transform.translate(
        offset: Offset((posX / 100) * minSize, (posY / 100) * minSize),
        child: Transform.rotate(
          angle: angle * pi / 180,
          child: Obx(() {
            TextStyle styleText;
            if (c.isBcathet.value) {
              styleText = AppStyleTextImage.active(context);
            } else {
              styleText = AppStyleTextImage.inActive(context);
            }

            return Text(
              c.bCathet.toString(),
              style: styleText,
            );
          }),
        ));
  }
}
