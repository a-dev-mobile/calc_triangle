import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppSize {
  static var iconSize = 30.sp;

  static const _default = 16.0;

  static double fontSizeButton(BuildContext context) {
    return Theme.of(context).textTheme.labelLarge?.fontSize ?? _default;
  }

  static double fontSizeHeadline6(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge?.fontSize ?? _default;
  }

  static double fontSizeHeadline5(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall?.fontSize ?? _default;
  }

  static double fontSizeHeadline4(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium?.fontSize ?? _default;
  }

  static double fontSizeHeadline3(BuildContext context) {
    return Theme.of(context).textTheme.displaySmall?.fontSize ?? _default;
  }

  static double fontSizeBodyText1(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge?.fontSize ?? _default;
  }

  static double fontSizeBodyText2(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.fontSize ?? _default;
  }
}
