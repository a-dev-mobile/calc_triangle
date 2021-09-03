// ignore_for_file: avoid_print



import 'package:calc_triangle/app/controller/right_triangle/right_triangle_c.dart';
import 'package:calc_triangle/app/ui/theme/app_color.dart';
import 'package:calc_triangle/app/ui/theme/app_size.dart';
import 'package:calc_triangle/app/ui/theme/app_style.dart';

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

    double minSize = AppSize.imageMinSize();

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
