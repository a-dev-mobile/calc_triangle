import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppSize {
  static var iconSize = 30.sp;

  static const _default = 16.0;

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

  static double fontSizeBodyText1(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1?.fontSize ?? _default;
  }

  static double fontSizeBodyText2(BuildContext context) {
    return Theme.of(context).textTheme.bodyText2?.fontSize ?? _default;
  }
}
