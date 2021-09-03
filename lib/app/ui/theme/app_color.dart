import 'package:calc_triangle/app/constant/const.dart';
import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';


abstract class AppColors {
  static Color content(BuildContext context) {
    return Theme.of(context).scaffoldBackgroundColor;
  }

  static Color text(BuildContext context) {
    Color color = Theme.of(context).textTheme.bodyText1?.color ?? Colors.red;
    return color;
  }

  static Color contentReverse(BuildContext context) {
    Color color = GetStorage().read(ConstString.keyIsDarkTheme) == false
        ? ConstColor.scaffoldDarkTheme
        : ConstColor.scaffoldLightTheme;
    return color;
  }
}





