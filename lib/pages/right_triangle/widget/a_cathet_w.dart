// ignore_for_file: avoid_print

import 'package:calc_triangle/const.dart';
import 'package:calc_triangle/controllers/r_triangle_c.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AcathetWidget extends StatelessWidget {
  const AcathetWidget({Key? key}) : super(key: key);

  static const double posX = 0;
  static const double posY = 43.345;
  static const double angle = 0;

  @override
  Widget build(BuildContext context) {
    RtriangleController c = Get.find();
    double minSize = GetStorage().read(ConstGet.minSize);

    return Transform.translate(
        offset: Offset((posX / 100) * minSize, (posY / 100) * minSize),
        child: Obx(() {

          Color colorText;
          if (c.isAcathet.value) {
            colorText = Colors.red;
          } else {
            colorText = Colors.white;
          }

          print('obx aCathet');
          return Text(
            c.aCathet.toString(),
            style: TextStyle(
                backgroundColor: ConstColors.scaffoldBackground,
                fontSize: 50.sp,
                color: colorText),
          );
        }));
  }
}
