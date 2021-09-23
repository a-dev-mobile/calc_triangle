// ignore_for_file: invalid_use_of_protected_member

import 'dart:math';


import 'package:calc_triangle/app/controller/calculate/scalene_triangle_c.dart';
import 'package:calc_triangle/app/ui/theme/app_style.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class YangleWidget extends StatelessWidget {
  const YangleWidget(
      {Key? key, required this.posX, required this.posY, required this.angle})
      : super(key: key);

  final double posX;
  final double posY;
  final double angle;
  @override
  Widget build(BuildContext context) {
    ScaleneTriangleController c = Get.find();

double minSize = ScaleneTriangleController.to.minSizeImage;
    TextStyle styleText;
    bool isActiveInput;
    bool isActiveParam;
    return Transform.translate(
        offset: Offset((posX / 100) * minSize, (posY / 100) * minSize),
        child: Transform.rotate(
            angle: angle * pi / 180,
            child: Obx(() {
              isActiveInput = c.isyAngle.value;
              isActiveParam =
                  c.activeParamMap.value.containsValue(ScaleneTriangle.yAngle);
              if (isActiveInput) {
                styleText = AppStyleTextImage.activeInput(context);
              } else if (isActiveParam) {
                styleText = AppStyleTextImage.activeParam(context);
              } else {
                styleText = AppStyleTextImage.inActive(context);
              }

              return GestureDetector(
                  onTap: () {
                    c.isaSide.value = false;
                    c.isbSide.value = false;
                    c.iscSide.value = false;
                    c.ishHeight.value = false;
                    c.isaAngle.value = false;
                    c.isbAngle.value = false;
                    c.isyAngle.value = true;
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
                    color: Colors.transparent,
                    child: Text(
                      c.yAngle.value,
                      style: styleText,
                    ),
                  ));
            })));
  }
}
