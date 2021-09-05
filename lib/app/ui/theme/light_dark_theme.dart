import 'package:calc_triangle/app/constant/const.dart';
import 'package:flutter/material.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
      primaryColor: ConstColor.primary,
      scaffoldBackgroundColor: ConstColor.scaffoldLightTheme,
      appBarTheme: appBarTheme,
      textTheme: Theme.of(context).textTheme.apply(
          fontFamily: 'montserrat', bodyColor: ConstColor.scaffoldDarkTheme),
      colorScheme: const ColorScheme.light(
        primary: ConstColor.primary,
        secondary: ConstColor.secondary,
        error: ConstColor.error,
      ));
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
      primaryColor: ConstColor.primary,
      scaffoldBackgroundColor: ConstColor.scaffoldDarkTheme,
      appBarTheme: appBarTheme,
      textTheme: Theme.of(context).textTheme.apply(
            fontFamily: 'montserrat',
            bodyColor: ConstColor.scaffoldLightTheme,
          ),
      colorScheme: const ColorScheme.dark().copyWith(
        primary: ConstColor.primary,
        secondary: ConstColor.secondary,
        error: ConstColor.error,
      ));
}

const appBarTheme =
    AppBarTheme(color: ConstColor.primary, centerTitle: false, elevation: 0);
