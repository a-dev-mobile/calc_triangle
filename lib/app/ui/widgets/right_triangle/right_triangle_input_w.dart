import 'package:calc_triangle/app/constant/const_number.dart';
import 'package:calc_triangle/app/controller/calculate/right_triangle_c.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';
import 'package:calc_triangle/app/ui/theme/app_color.dart';
import 'package:calc_triangle/app/ui/theme/app_style.dart';
import 'package:calc_triangle/app/ui/widgets/numpad/numpad_w.dart';
import 'package:calc_triangle/main.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'widget/r_triangle_image_input_w.dart';


class RightTriangleInputWidget extends StatelessWidget {
  const RightTriangleInputWidget({Key? key}) : super(key: key);



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
                Text(
                  TranslateHelper.rightTriangle,
                  style: AppStyleText.titleText(context),
                ),
                Divider(
                  indent: 50.w,
                  endIndent: 50.w,
                  color: AppColors.text(context),
                ),
                Text(
                  TranslateHelper.enterTwoParameters,
                  style: AppStyleText.subText(context),
                ),
                
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(ConstNumber.defaultMargin),
                    decoration: BoxDecoration(
                        color: AppColors.content(context),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(ConstNumber.defaultRadius))),
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
