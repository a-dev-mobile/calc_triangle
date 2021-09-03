import 'package:calc_triangle/app/constant/const.dart';
import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';


abstract class AppColors {
  static Color content(BuildContext context) {
    return Theme.of(context).scaffoldBackgroundColor;
  }

  static Color text(BuildContext context) {
    Color color = Theme.of(context).textTheme.bodyText1?.color ?? Colors.white;
    return color;
  }

  static Color contentReverse(BuildContext context) {
    Color color = GetStorage().read(ConstString.keyIsDarkTheme) == false
        ? ConstColor.scaffoldDarkTheme
        : ConstColor.scaffoldLightTheme;
    return color;
  }
}


abstract class AppSize {
  static const _default = 16.0;


   static double imageMinSize() {
    var minSize = GetStorage().read(ConstString.keyMinSize) ?? 0;


    return minSize;
  }
  static double fontSizeButton(BuildContext context) {
    return Theme.of(context).textTheme.button?.fontSize ?? _default;
  }

  static double fontSizeHeadline6(BuildContext context) {
    return Theme.of(context).textTheme.headline6?.fontSize ?? _default;
  }

  static double fontSizeHeadline5(BuildContext context) {
    return Theme.of(context).textTheme.headline5?.fontSize ?? _default;
  }

  static double fontSizeHeadline4(BuildContext context) {
    return Theme.of(context).textTheme.headline4?.fontSize ?? _default;
  }

  static double fontSizeHeadline3(BuildContext context) {
    return Theme.of(context).textTheme.headline3?.fontSize ?? _default;
  }
}


