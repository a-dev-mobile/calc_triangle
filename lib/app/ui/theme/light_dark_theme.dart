import 'package:flutter/material.dart';

import 'app_color_style.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: kScaffoldColorLightTheme,
      appBarTheme: appBarTheme,
      textTheme: Theme.of(context)
          .textTheme
          .apply(fontFamily: 'montserrat', bodyColor: kScaffoldColorDarkTheme),
      colorScheme: ColorScheme.light(
        primary: kPrimaryColor,
        secondary: kSecondaryColor,
        error: kErrorColor,
      ));
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: kScaffoldColorDarkTheme,
      appBarTheme: appBarTheme,
      textTheme: Theme.of(context)
          .textTheme
          .apply(fontFamily: 'montserrat', bodyColor: kScaffoldColorLightTheme),
      colorScheme:  const ColorScheme.dark().copyWith(
        primary: kPrimaryColor,
        secondary: kSecondaryColor,
        error: kErrorColor,
      ));
}

final appBarTheme =
    AppBarTheme(color: kPrimaryColor, centerTitle: false, elevation: 0);
