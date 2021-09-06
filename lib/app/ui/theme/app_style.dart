import 'package:calc_triangle/app/constant/const.dart';
import 'package:calc_triangle/app/ui/theme/app_color.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_size.dart';

abstract class AppStyleNumpad {
  static TextStyle function(BuildContext context) {
    return TextStyle(color: const Color(0xffF50021), fontSize: 40.sp);
  }

  static TextStyle operator(BuildContext context) {
    return TextStyle(color: ConstColor.primary, fontSize: 40.sp);
  }

  static TextStyle integer(BuildContext context) {
    return TextStyle(color: AppColors.text(context), fontSize: 40.sp);
    // fontSize: AppSize.fontSizeHeadline5(context));
  }
  
   static TextStyle convert(BuildContext context) {
    return TextStyle(color: AppColors.text(context), fontSize: 30.sp);
    // fontSize: AppSize.fontSizeHeadline5(context));
  }
}

abstract class AppStyleDrawer {
  static TextStyle textAppName =
      TextStyle(color: const Color(0xff000000), fontSize: 30.sp);
  static TextStyle textAppNameSub =
      TextStyle(color: const Color(0xe6000000), fontSize: 20.sp);

  static TextStyle textItem =
      TextStyle(color: const Color(0xe6000000), fontSize: 20.sp);

  static const colorIcon = Color(0xffA0A0A0);
  static double sizeIcon = 20.sp;
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
  static TextStyle text(BuildContext context) {
    return TextStyle(
        color: AppColors.text(context),
        height: 1,
        // backgroundColor: Colors.blue,
        backgroundColor: AppColors.content(context),
        fontSize: 20.sp);
  }

  static TextStyle active(BuildContext context) {
    return TextStyle(
        color: Colors.red,
        backgroundColor: AppColors.content(context),
        fontSize: 25.sp);
  }

  static TextStyle inActive(BuildContext context) {
    return TextStyle(
        color: AppColors.text(context),
        backgroundColor: AppColors.content(context),
        fontSize: 20.sp);
  }
}

abstract class AppStyleButton {
  static TextStyle start(BuildContext context) {
    return TextStyle(
      // color: AppColors.text(context),
      // backgroundColor: AppColors.content(context),
      fontSize: 35.sp,
      letterSpacing: 8,
      fontWeight: FontWeight.bold,
    );
  }

  static Widget iconActiveTheme(BuildContext context) {
    return Icon(
      Icons.check,
      color: Theme.of(context).primaryColor,
      size: 35.sp,
    );
  }

  static Widget iconNotActiveTheme(BuildContext context) {
    return Container();
  }
}
