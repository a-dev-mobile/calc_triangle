import 'package:calc_triangle/app/constant/const.dart';
import 'package:calc_triangle/app/controller/right_triangle/right_triangle_c.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';
import 'package:calc_triangle/app/ui/theme/app_color.dart';
import 'package:calc_triangle/app/ui/theme/app_style.dart';
import 'package:calc_triangle/main.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'widget/r_triangle_image_input_w.dart';
import 'widget/numpad_w.dart';

class RightTriangleInputWidget extends StatelessWidget {
  const RightTriangleInputWidget({Key? key}) : super(key: key);
  static const maxSelected = 2;
  static const maxValue = 5;

  @override
  Widget build(BuildContext context) {
    RightTriangleController c = Get.find();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const RightTriangleImageInputWidget(),
                Stack(
                  children: [
                    Column(
                      children: [
                        Text(
                          TranslateHelper.rightTriangle,
                          style: AppStyleTextInfo.mainText(context),
                        ),
                        Divider(
                          indent: 50.w,
                          endIndent: 50.w,
                          color: AppColors.text(context),
                        ),
                        Text(
                          TranslateHelper.enterTwoParameters,
                          style: AppStyleTextInfo.subText(context),
                        ),
                      ],
                    ),
                    Positioned(
                        top: 0,
                        bottom: 0,
                        right: 0,
                        child: InkResponse(
                          onTap: () {
                            c.isActiveInputImage.value =
                                !c.isActiveInputImage.value;
                          },
                          child: Icon(
                            Icons.info_outline,
                            size: 50.sp,
                            color: ConstColor.primary,
                          ),
                        ))
                  ],
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(ConstDefaultDouble.margin),
                    decoration: BoxDecoration(
                        color: AppColors.content(context),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(ConstDefaultDouble.radius))),
                    child: const NumPad(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
