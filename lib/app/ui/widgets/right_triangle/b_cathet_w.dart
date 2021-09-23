// ignore_for_file: invalid_use_of_protected_member

import 'dart:math';

import 'package:calc_triangle/app/controller/calculate/right_triangle_c.dart';
import 'package:calc_triangle/app/ui/theme/app_style.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    RightTriangleController c = Get.find();

    double minSize = RightTriangleController.to.minSizeImage;
    TextStyle styleText;
    bool isActiveInput;
    bool isActiveParam;
    return Transform.translate(
        offset: Offset((posX / 100) * minSize, (posY / 100) * minSize),
        child: Transform.rotate(
            angle: angle * pi / 180,
            child: Obx(() {
              isActiveInput = c.isbCathet.value;
              isActiveParam =
                  c.activeParamMap.value.containsValue(RightTriangle.bCathet);
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
                    c.isbCathet.value = true;
                    c.iscHypotenuse.value = false;
                    c.ishHeight.value = false;
                    c.ismCompCside.value = false;
                    c.iskCompCside.value = false;
                    c.isaAngle.value = false;
                    c.isbAngle.value = false;
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
                    color: Colors.transparent,
                    child: Text(
                      c.bCathet.value,
                      style: styleText,
                    ),
                  ));
            })));
  }
}
