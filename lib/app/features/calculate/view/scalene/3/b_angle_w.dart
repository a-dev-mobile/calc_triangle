// ignore_for_file: invalid_use_of_protected_member

import 'dart:math';

import 'package:calc_triangle/app/config/theme/app_style.dart';
import 'package:calc_triangle/app/features/calculate/controllers/scalene_c.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

ScaleneTriangleController c = ScaleneTriangleController.to;

class BangleWidget extends StatelessWidget {
  const BangleWidget({
    required this.posX,
    required this.posY,
    required this.angle,
    required this.minSizeImage,
    super.key,
  });

  final double posX;
  final double posY;
  final double angle;
  final double minSizeImage;

  // ====change====
  void onTap() {
    c.isaSide.value = false;
    c.isbSide.value = false;
    c.iscSide.value = false;
    c.ishHeight.value = false;
    c.isaAngle.value = false;
    c.isbAngle.value = true;
    c.isyAngle.value = false;
    c.showMessage();
  }

  //===============
  @override
  Widget build(BuildContext context) {
    TextStyle styleText;

    bool isActiveInput;
    bool isActiveParam;
    ScaleneTriangle elementFigure;
    String activeValue;
    return Transform.translate(
      offset: Offset((posX / 100) * minSizeImage, (posY / 100) * minSizeImage),
      child: Transform.rotate(
        angle: angle * pi / 180,
        child: Obx(() {
          // ====change====
          activeValue = c.bAngle.value;
          isActiveInput = c.isbAngle.value;
          elementFigure = ScaleneTriangle.bAngle;
          //===============
          isActiveParam = c.activeParamMap.value.containsValue(elementFigure);
          if (isActiveInput) {
            styleText = AppStyleTextImage.activeInput(context);
          } else if (isActiveParam) {
            styleText = AppStyleTextImage.activeParam(context);
          } else {
            styleText = AppStyleTextImage.inActive(context);
          }

          return GestureDetector(
            onTap: () {
              onTap();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
              color: Colors.transparent,
              child: Text(activeValue, style: styleText),
            ),
          );
        }),
      ),
    );
  }
}
