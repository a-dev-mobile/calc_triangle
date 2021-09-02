import 'dart:math';

import 'package:calc_triangle/app/constant/string_const.dart';

import 'package:calc_triangle/app/controller/right_triangle/right_triangle_c.dart';
import 'package:calc_triangle/app/ui/theme/app_color_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../styles.dart';

class BangleWidget extends StatelessWidget {
  const BangleWidget(
      {Key? key, required this.posX, required this.posY, required this.angle})
      : super(key: key);

  final double posX;
  final double posY;
  final double angle;
  @override
  Widget build(BuildContext context) {
RightTriangleController c = Get.find();
    double minSize = GetStorage().read(StringConst.keyMinSize);

    return Transform.translate(
        offset: Offset((posX / 100) * minSize, (posY / 100) * minSize),
        child: Transform.rotate(
          angle: angle * pi / 180,
          child: Obx(() {
            TextStyle styleText;
            if (c.isBangle.value) {
              styleText = StyleTextImage.active;
            } else {
              styleText = StyleTextImage.inActive;
            }
            print('obx bAngle');
            return Text(
              c.bAngle.toString(),
              style: styleText,
            );
          }),
        ));
  }
}
