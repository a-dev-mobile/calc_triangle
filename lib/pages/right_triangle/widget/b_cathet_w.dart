import 'dart:math';

import 'package:calc_triangle/const.dart';
import 'package:calc_triangle/controllers/r_triangle_c.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BcathetWidget extends StatelessWidget {
  const BcathetWidget({Key? key, required this.posX, required this.posY, required this.angle}) : super(key: key);


 
  final double posX;
  final double posY;
  final double angle;
  @override
  Widget build(BuildContext context) {
    RtriangleController c = Get.find();
    double minSize = GetStorage().read(ConstGet.minSize);

    return Transform.translate(
        offset: Offset((posX / 100) * minSize, (posY / 100) * minSize),
        child: Transform.rotate(
          angle: angle * pi / 180,
          child: Obx(() {


        Color colorText;
          if (c.isBcathet.value) {
            colorText = Colors.red;
          } else {
            colorText = Colors.white;
          }

                  print('obx bCathet');
            return Text(
              c.bCathet.toString(),
              style: TextStyle(
                  backgroundColor: ConstColors.scaffoldBackground,
                  fontSize: 50.sp,
                  color: colorText),
            );
          }),
        ));
  }
}
