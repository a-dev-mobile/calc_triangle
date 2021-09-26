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
