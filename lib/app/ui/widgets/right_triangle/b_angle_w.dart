// ignore_for_file: invalid_use_of_protected_member


import 'package:calc_triangle/app/controller/calculate_right/right_triangle_c.dart';
import 'package:calc_triangle/app/ui/theme/app_style.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class BangleWidget extends StatelessWidget {
  const BangleWidget({Key? key, required this.posX, required this.posY})
      : super(key: key);

  final double posX;
  final double posY;

  @override
  Widget build(BuildContext context) {
    RightTriangleController c = Get.find();
     double minSize = RightTriangleController.to.minSizeImage;
    TextStyle styleText;
    bool isActiveInput;
    bool isActiveParam;
    return Transform.translate(
        offset: Offset((posX / 100) * minSize, (posY / 100) * minSize),
        child: Obx(() {
          isActiveInput = c.isbAngle.value;
          isActiveParam =
              c.activeParamMap.value.containsValue(RightTriangle.bAngle);
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
                c.isaAngle.value = false;
                c.isbAngle.value = true;
              },
              child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
                  color: Colors.transparent,
                  child: Text(
                    c.bAngle.value,
                    style: styleText,
                  )));
        }));
  }
}
