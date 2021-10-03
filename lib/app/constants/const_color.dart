import 'dart:ui';

abstract class ConstColor {
  static const Color primary = Color(0xFF26a69a);

  static const Color secondary = Color(0xFF51b7ae);
//текст цвет если  color: Theme.of(context).textTheme.bodyText1!.color,
  static const Color scaffoldLightTheme = Color(0xFFF5FCF9);

  static const Color scaffoldDarkTheme = Color(0xFF121212);

  static const Color cardBgDark = Color(0xFF272727);
  static const Color cardBgLight = Color(0xFFffffff);
  
  static const Color warninng = Color(0xFFF3BB1C);
  static const Color error = Color(0xFFF03738);
}
