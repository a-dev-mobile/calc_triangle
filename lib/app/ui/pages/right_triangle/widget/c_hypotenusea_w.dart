// ignore_for_file: avoid_print

import 'dart:math';

import 'package:calc_triangle/app/constant/string_const.dart';
import 'package:calc_triangle/app/controller/r_triangle/r_triangle_c.dart';
import 'package:calc_triangle/app/ui/theme/app_color_style.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../styles.dart';

class ChypotenuseWidget extends StatelessWidget {
  const ChypotenuseWidget(
      {Key? key, required this.posX, required this.posY, required this.angle})
      : super(key: key);

  final double posX;
  final double posY;
  final double angle;
  @override
  Widget build(BuildContext context) {
    RtriangleController c = Get.find();
    double minSize = GetStorage().read(StringConst.keyMinSize);

    return Transform.translate(
        offset: Offset((posX / 100) * minSize, (posY / 100) * minSize),
        child: Transform.rotate(
          angle: angle * pi / 180,
          child: Obx(() {
            TextStyle styleText;
            if (c.isChypotenuse.value) {
              styleText = StyleTextImage.active;
            } else {
              styleText = StyleTextImage.inActive;
            }

            print('obx cHypotenuse');
            return Text(
              c.cHypotenuse.toString(),
              style: styleText,
            );
          }),
        ));
  }
}
