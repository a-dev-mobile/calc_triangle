import 'package:calc_triangle/app/constants/const_color.dart';
import 'package:calc_triangle/app/services/global_serv.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
      cardColor: ConstColor.cardBgLight,
      primaryColor: ConstColor.primary,
      scaffoldBackgroundColor: ConstColor.scaffoldLightTheme,
      appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: ConstColor.scaffoldLightTheme),
          iconTheme: const IconThemeData(color: ConstColor.scaffoldLightTheme),
          titleTextStyle: const TextStyle(
            color: ConstColor.scaffoldLightTheme,
            fontSize: 20,
          ),
          color: ConstColor.primary,
          elevation: 0),
      textTheme: Theme.of(context).textTheme.apply(
            fontFamily: 'montserrat',
            bodyColor: ConstColor.scaffoldDarkTheme,
          ),
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
      cardColor: ConstColor.cardBgDark,
      appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.light,
              statusBarColor: ConstColor.scaffoldDarkTheme),
          iconTheme: const IconThemeData(color: ConstColor.scaffoldDarkTheme),
          titleTextStyle: const TextStyle(
            color: ConstColor.scaffoldDarkTheme,
            fontSize: 20,
          ),
          color: ConstColor.primary,
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

void settingBar() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarIconBrightness:
          GlobalServ.to.isDarkTheme() ? Brightness.light : Brightness.dark,
      statusBarColor: GlobalServ.to.isDarkTheme()
          ? ConstColor.scaffoldDarkTheme
          : ConstColor.scaffoldLightTheme, // Color for Android
      statusBarBrightness: GlobalServ.to.isDarkTheme()
          ? Brightness.dark
          : Brightness.light // Dark == white status bar -- for IOS.
      ));
}
