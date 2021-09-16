// ignore_for_file: avoid_print, invalid_use_of_protected_member

import 'package:calc_triangle/app/controller/calculate/right_triangle_c.dart';
import 'package:calc_triangle/app/ui/theme/app_style.dart';
import 'package:calc_triangle/app/utils/app_utils.dart';
import 'package:calc_triangle/main.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class AcathetWidget extends StatelessWidget {
  const AcathetWidget(
      {Key? key, required this.posX, required this.posY,})
      : super(key: key);

  final double posX;
  final double posY;

  @override
  Widget build(BuildContext context) {
    RightTriangleController c = Get.find();

    double minSize = AppUtils.getImageMinSize();
    TextStyle styleText;
    bool isActiveInput;
    bool isActiveParam;
    return Transform.translate(
        offset: Offset((posX / 100) * minSize, (posY / 100) * minSize),
        child: Obx(() {
          isActiveInput = c.isaCathet.value;
          isActiveParam =
              c.activeParamMap.value.containsValue(RightTriangle.aCathet);
          if (isActiveInput) {
            styleText = AppStyleTextImage.activeInput(context);
          } else if (isActiveParam) {
            styleText = AppStyleTextImage.activeParam(context);
          } else {
            styleText = AppStyleTextImage.inActive(context);
          }

          return GestureDetector(
                onTap: () {
                
                     c.isaCathet.value = true;
                  c.isbCathet.value = false;
                  c.iscHypotenuse.value = false;
           c.ishHeight.value = false;
                  c.ismCompCside.value = false;
                  c.iskCompCside.value = false;
                  c.isaAngle.value = false;
                  c.isbAngle.value = false;


                },
                child: Container(
             
                  padding: EdgeInsets.symmetric(horizontal: 20.h,vertical: 10.h),
                  color: Colors.transparent,
                  child: Text(
                  c.aCathet.value,
                  style: styleText,
                ),
              ));
        }));
  }
}
