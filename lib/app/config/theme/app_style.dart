import 'package:calc_triangle/app/constants/const_color.dart';



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_color.dart';

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
    return TextStyle(color: ConstColor.secondary, fontSize: 30.sp);
    // fontSize: AppSize.fontSizeHeadline5(context));
  }
}

abstract class AppStyleDrawer {
  static TextStyle textAppName(BuildContext context) {
    return TextStyle(color: AppColors.text(context), fontSize: 25.sp);
  }

  static TextStyle textAppNameSub(BuildContext context) {
    return TextStyle(color: AppColors.text(context), fontSize: 15.sp);
  }

  static TextStyle textItem(BuildContext context) {
    return TextStyle(color: AppColors.text(context), fontSize: 20.sp);
  }

  static double iconSize = 20.sp;
  static Color iconColor(BuildContext context) {
    return AppColors.contentRevers(context);
  }
}

abstract class AppStyleText {
  static TextStyle titleText(BuildContext context) {
    return TextStyle(
        color: AppColors.text(context),
        fontSize: 15.sp,
        fontWeight: FontWeight.bold);
  }
  static TextStyle textSettingItem(BuildContext context) {
    return TextStyle(
        color: AppColors.text(context),
        fontSize: 15.sp,
       );
  }
  static TextStyle subText(BuildContext context) {
    return TextStyle(
        color: AppColors.text(context).withOpacity(0.8), fontSize: 15.sp);
  }

  static TextStyle convertText(BuildContext context) {
    return TextStyle(color: AppColors.text(context), fontSize: 26.sp);
  }


  static TextStyle leadingTextDetail(BuildContext context) {
    return TextStyle(
        color: AppColors.text(context),
        fontSize: 20.sp,
        fontWeight: FontWeight.bold);
  }



}

abstract class AppStyleTextImage {
  static TextStyle text(BuildContext context) {
    return TextStyle(
        color: AppColors.text(context),
        height: 1,
        // backgroundColor: Colors.blue,
        backgroundColor: AppColors.content(context),
        fontSize: 24.sp);
  }

  static TextStyle activeInput(BuildContext context) {
    return TextStyle(
        color: ConstColor.error,
        fontWeight: FontWeight.bold,
        backgroundColor: AppColors.content(context),
        fontSize: 20.sp);
  }

  static TextStyle activeParam(BuildContext context) {
    return TextStyle(
        color: ConstColor.primary,
        backgroundColor: AppColors.content(context),
        fontSize: 20.sp);
  }

  static TextStyle inActive(BuildContext context) {
    return TextStyle(
        color: AppColors.text(context),
        backgroundColor: AppColors.content(context),
        fontSize: 18.sp);
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
