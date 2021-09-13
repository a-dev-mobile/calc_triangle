import 'package:calc_triangle/app/constant/const_color.dart';
import 'package:calc_triangle/app/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
      primaryColor: ConstColor.primary,
      scaffoldBackgroundColor: ConstColor.scaffoldLightTheme,
      appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: ConstColor.scaffoldLightTheme),
          iconTheme: const IconThemeData(color: ConstColor.scaffoldDarkTheme),
          titleTextStyle: const TextStyle(
            color: ConstColor.scaffoldDarkTheme,
            fontSize: 20,
          ),
          color: Colors.transparent,
          centerTitle: true,
          elevation: 0),
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
      appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.light,
              statusBarColor: ConstColor.scaffoldDarkTheme),
          iconTheme: const IconThemeData(color: ConstColor.scaffoldLightTheme),
          titleTextStyle: const TextStyle(
            color: ConstColor.scaffoldLightTheme,
            fontSize: 20,
          ),
          color: Colors.transparent,
          centerTitle: true,
          elevation: 0),
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
