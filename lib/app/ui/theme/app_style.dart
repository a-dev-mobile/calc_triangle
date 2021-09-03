import 'package:calc_triangle/app/constant/const.dart';
import 'package:calc_triangle/app/ui/theme/app_color.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_size.dart';

abstract class AppStyleNumpad {
  static TextStyle function(BuildContext context) {
    return TextStyle(color: const Color(0xffF50021), fontSize: 80.sp);
  }

  static TextStyle operator =
      TextStyle(color: ConstColor.primary, fontSize: 150.sp);

  static TextStyle integer(BuildContext context) {
    return TextStyle(
        color: AppColors.text(context),
        fontSize: AppSize.fontSizeHeadline6(context));
  }
}

abstract class AppStyleDrawer {
  static TextStyle textAppName =
      TextStyle(color: const Color(0xff000000), fontSize: 80.sp);
  static TextStyle textAppNameSub =
      TextStyle(color: const Color(0xe6000000), fontSize: 60.sp);

  static TextStyle textItem =
      TextStyle(color: const Color(0xe6000000), fontSize: 60.sp);

  static const colorIcon = Color(0xffA0A0A0);
  static double sizeIcon = 120.sp;
}

abstract class AppStyleTextInfo {
  static TextStyle mainText(BuildContext context) {
    return TextStyle(
        color: AppColors.text(context),
        fontSize: AppSize.fontSizeHeadline6(context));
  }

  static TextStyle subText(BuildContext context) {
    return TextStyle(
        color: AppColors.text(context),
        fontSize: AppSize.fontSizeButton(context));
  }
}

abstract class AppStyleTextImage {
  static TextStyle active(BuildContext context) {
    return TextStyle(
        color: Colors.red,
        backgroundColor: AppColors.content(context),
        fontSize: AppSize.fontSizeHeadline6(context));
  }

  static TextStyle inActive(BuildContext context) {
    return TextStyle(
        color: AppColors.text(context),
        backgroundColor: AppColors.content(context),
        fontSize: AppSize.fontSizeButton(context));
  }
}
