import 'package:calc_triangle/app/config/theme/app_style.dart';
import 'package:calc_triangle/app/features/calculate/controllers/right_c.dart';


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

late RightTriangleController c = RightTriangleController.to;

class AcathetWidget extends StatelessWidget {
  const AcathetWidget(
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
          isActiveInput = c.isaCathet.value;
          isActiveParam = c.activeParamMap.containsValue(RightTriangle.aCathet);
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
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
                color: Colors.transparent,
                child: Text(
                  c.aCathet.value,
                  style: styleText,
                ),
              ));
        }));
  }
}
