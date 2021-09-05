import 'package:calc_triangle/app/constant/const.dart';
import 'package:calc_triangle/app/ui/theme/app_utils.dart';
import 'package:calc_triangle/main.dart';
import 'package:flutter/material.dart';

abstract class AppColors {
  static Color content(BuildContext context) {
    return Theme.of(context).scaffoldBackgroundColor;
  }

  static Color text(BuildContext context) {
    Color color = Theme.of(context).textTheme.bodyText1?.color ?? Colors.red;
    return color;
  }

  static Color contentRevers(BuildContext context) {
    Color color = Theme.of(context).textTheme.bodyText1?.color ?? Colors.red;
    return color;
  }
  // static Color contentReverse = AppUtils.isDark
  //     ? ConstColor.scaffoldDarkTheme
  //     : ConstColor.scaffoldLightTheme;
}
