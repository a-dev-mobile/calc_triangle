import 'dart:math';

import 'package:calc_triangle/app/config/theme/app_style.dart';
import 'package:calc_triangle/app/features/calculate/controllers/right_c.dart';


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

late var c = RightTriangleController.to;

class AangleWidget extends StatelessWidget {
  const AangleWidget(
      {Key? key,
      required this.posX,
      required this.posY,
      required this.angle,
      required this.minSizeImage})
      : super(key: key);

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
    c.ismCompCside.value = false;
    c.iskCompCside.value = false;
    c.isaAngle.value = true;
    c.isbAngle.value = false;

    c.showMessage();
  }

  //===============
  @override
  Widget build(BuildContext context) {
    TextStyle styleText;
    bool isActiveInput;
    bool isActiveParam;
    RightTriangle elementFigure;
    String activeValue;
    return Transform.translate(
        offset:
            Offset((posX / 100) * minSizeImage, (posY / 100) * minSizeImage),
        child: Transform.rotate(
            angle: angle * pi / 180,
            child: Obx(() {
              // ====change====
              activeValue = c.aAngle.value;
              isActiveInput = c.isaAngle.value;
              elementFigure = RightTriangle.aAngle;
              //===============
              isActiveParam = c.activeParamMap.containsValue(elementFigure);
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
                    color: Colors.transparent,
                    child: Text(
                      activeValue,
                      style: styleText,
                    ),
                  ));
            })));
  }
}
