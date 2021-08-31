// ignore_for_file: avoid_print

import 'dart:math';

import 'package:calc_triangle/constants.dart';
import 'package:calc_triangle/controllers/r_triangle_c.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChypotenuseWidget extends StatelessWidget {
  const ChypotenuseWidget({Key? key, required this.posX, required this.posY, required this.angle}) : super(key: key);

  final double posX;
  final double posY;
  final double angle;
  @override
  Widget build(BuildContext context) {
    RtriangleController c = Get.find();
    double minSize = GetStorage().read(kGetStorageMinSize);

    return Transform.translate(
        offset: Offset((posX / 100) * minSize, (posY / 100) * minSize),
        child: Transform.rotate(
          angle: angle * pi / 180,
          child: Obx(() {
            Color colorText;
             if (c.isChypotenuse.value) {
              colorText = kActivTextColor;
            } else {
              colorText = kInActivTextColor;
            }

            print('obx cHypotenuse');
            return Text(
              c.cHypotenuse.toString(),
              style: TextStyle(
                   backgroundColor: kBgColorContent,
                  fontSize: 80.sp,
                  color:  colorText),
            );
          }),
        ));
  }
}
