import 'package:calc_triangle/app/constant/string_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Color kPrimaryColor =
    GetStorage().read(StringConst.keyPrimaryColor) == 'purple'
        ? Color(0xFF6a0080)
        : Color(0xFF1a746b);
Color kMedColor = const Color(0xFF26a69a);
Color kSecondaryColor = const Color(0xFF51b7ae);
//текст цвет если  color: Theme.of(context).textTheme.bodyText1!.color,
Color kScaffoldColorLightTheme = const Color(0xFFF5FCF9);

Color kScaffoldColorDarkTheme = const Color(0xFF1D1D35);
Color kWarninngColor = const Color(0xFFF3BB1C);
Color kErrorColor = const Color(0xFFF03738);

const double kDefaultPadding = 20.0;
const double kDefaultMargin = 5.0;
const double kDefaultRadius = 32.0;

abstract class ColorsApp {
  static Color content(BuildContext context) {
    return Theme.of(context).scaffoldBackgroundColor;
  }

  static Color text(BuildContext context) {
    Color color = Theme.of(context).textTheme.bodyText1?.color ?? Colors.white;

    return color;
  }

  static Color contentReverse(BuildContext context) {
    Color color = GetStorage().read(StringConst.keyIsDarkTheme) == false
        ? kScaffoldColorDarkTheme
        : kScaffoldColorLightTheme;
    return color;
  }
}

abstract class SizeApp {
  static double button(BuildContext context) {
    return Theme.of(context).textTheme.button?.fontSize ?? 16.0;
  }

  static double headline6(BuildContext context) {
    return Theme.of(context).textTheme.headline6?.fontSize ?? 16.0;
  }

  static double headline5(BuildContext context) {
    return Theme.of(context).textTheme.headline5?.fontSize ?? 16.0;
  }

  static double headline4(BuildContext context) {
    return Theme.of(context).textTheme.headline4?.fontSize ?? 16.0;
  }

  static double headline3(BuildContext context) {
    return Theme.of(context).textTheme.headline3?.fontSize ?? 16.0;
  }
}
