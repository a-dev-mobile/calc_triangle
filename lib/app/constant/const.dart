import 'package:flutter/material.dart';
abstract class ConstColor {
    static const Color primary = Colors.teal;

    static const Color med =  Color(0xFF26a69a);
    static const Color secondary = Color(0xFF51b7ae);
//текст цвет если  color: Theme.of(context).textTheme.bodyText1!.color,
    static const Color scaffoldLightTheme = Color(0xFFF5FCF9);

    static const Color scaffoldDarkTheme = Color(0xFF1D1D35);
    static const Color warninng = Color(0xFFF3BB1C);
    static const Color error = Color(0xFFF03738);
}

abstract class ConstString {
  static const String keyMinSize = 'minSize';
  static const String keyPrimaryColor = 'primary_color';
  static const String keySecondaryColor = 'secondary_color';

  static const String keyIsDarkTheme = 'is_dark_theme';
  static const String keyIsFirstStart = 'is_first_start';
}

abstract class ConstAssets {
  static const String righTriangleInput =
      'assets/image/triangle/r_triangle_input.png';
  static const String righTriangleInfo =
      'assets/image/triangle/r_triangle_info.png';

  static const String welcomeImage = 'assets/image/welcome/welcome_app.png';
}


abstract class ConstDefaultDouble {
  static const double padding = 20.0;
  static const double margin = 5.0;
  static const double radius = 32.0;
  static const double ratioFigureImage = 0.4;
}
