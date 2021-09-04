import 'package:calc_triangle/app/constant/const.dart';
import 'package:calc_triangle/app/controller/right_triangle/right_triangle_c.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';
import 'package:calc_triangle/app/ui/theme/app_color.dart';
import 'package:calc_triangle/app/ui/theme/app_style.dart';
import 'package:calc_triangle/app/ui/widgets/drawer/drawer_icon_w.dart';
import 'package:calc_triangle/app/ui/widgets/drawer/drawer_w.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'widget/r_triangle_image_info_w.dart';
import 'widget/r_triangle_image_input_w.dart';
import 'widget/numpad_w.dart';

class RightTriangleInputWidget extends StatelessWidget {
  RightTriangleInputWidget({Key? key}) : super(key: key);
  static const maxSelected = 2;
  static const maxValue = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RightTriangleImageInputWidget(),
                Text(
                  TranslateHelper.rightTriangle,
                  style: AppStyleTextInfo.mainText(context),
                ),
                Divider(
                  color: AppColors.text(context),
                ),
                Text(
                  TranslateHelper.enterTwoParameters,
                  style: AppStyleTextInfo.subText(context),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(ConstDefaultDouble.margin),
                    decoration: BoxDecoration(
                        color: AppColors.content(context),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ConstDefaultDouble.radius))),
                    child: NumPad(),
                  ),
                ),
                Container(
                  width: 1.sw,
                  color: Colors.amber,
                  height: 0.08.sh,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
