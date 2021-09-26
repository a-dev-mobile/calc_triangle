// ignore_for_file: avoid_print, invalid_use_of_protected_member

import 'package:calc_triangle/app/constant/const_string.dart';
import 'package:calc_triangle/app/controller/calculate_right/right_triangle_c.dart';
import 'package:calc_triangle/app/services/global_serv.dart';
import 'package:calc_triangle/app/ui/theme/app_style.dart';
import 'package:calc_triangle/app/utils/local_torage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

late RightTriangleController c = RightTriangleController.to;

class AangleWidget extends StatelessWidget {
  const AangleWidget(
      {Key? key,
      required this.posX,
      required this.posY,
      required this.minSizeImage})
      : super(key: key);

  final double posX;
  final double posY;

  final double minSizeImage;

  @override
  Widget build(BuildContext context) {
    TextStyle styleText;
    bool isActiveInput;
    bool isActiveParam;
    return Transform.translate(
        offset:
            Offset((posX / 100) * minSizeImage, (posY / 100) * minSizeImage),
        child: Obx(() {
          isActiveInput = c.isaAngle.value;
          isActiveParam =
              c.activeParamMap.value.containsValue(RightTriangle.aAngle);

          if (isActiveInput) {
            styleText = AppStyleTextImage.activeInput(context);
          } else if (isActiveParam) {
            styleText = AppStyleTextImage.activeParam(context);
          } else {
            styleText = AppStyleTextImage.inActive(context);
          }

          return GestureDetector(
              onTap: () {
                c.isaCathet.value = false;
                c.isbCathet.value = false;
                c.iscHypotenuse.value = false;
                c.ishHeight.value = false;
                c.ismCompCside.value = false;
                c.iskCompCside.value = false;
                c.isaAngle.value = true;
                c.isbAngle.value = false;
              },
              child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
                  color: Colors.transparent,
                  child: Text(
                    c.aAngle.value,
                    style: styleText,
                  )));
        }));
  }
}
