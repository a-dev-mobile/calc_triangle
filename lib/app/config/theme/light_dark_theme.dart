import 'package:calc_triangle/app/constants/const_color.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/*
SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarIconBrightness:
            isDarkTheme.value ? Brightness.light : Brightness.dark,
        statusBarColor: isDarkTheme.value
            ? ConstColor.scaffoldDarkTheme
            : ConstColor.scaffoldLightTheme, // Color for Android
        statusBarBrightness: isDarkTheme.value
            ? Brightness.dark
            : Brightness.light // Dark == white status bar -- for IOS.
        ));

*/

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
