import 'package:calc_triangle/theme/app_color_codes.dart';
import 'package:flutter/material.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: kContentColorDarkTheme,
      appBarTheme: appBarTheme,
      textTheme: Theme.of(context)
          .textTheme
          .apply(fontFamily: 'montserrat', bodyColor: kContentColorLightTheme),
      colorScheme: ColorScheme.light(
        primary: kPrimaryColor,
        secondary: kSecondaryColor,
        error: kErrorColor,
      ));
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: kContentColorLightTheme,
      appBarTheme: appBarTheme,
      textTheme: Theme.of(context)
          .textTheme
          .apply(fontFamily: 'montserrat', bodyColor: kContentColorDarkTheme),
      colorScheme: const ColorScheme.dark().copyWith(
        primary: kPrimaryColor,
        secondary: kSecondaryColor,
        error: kErrorColor,
      ));
}

final appBarTheme =
    AppBarTheme(color: kPrimaryColor, centerTitle: false, elevation: 0);
