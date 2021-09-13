import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TranslateHelper {
  // он предназначен для предотвращения создания экземпляра TranslateHelper
  TranslateHelper._();
  static updateLocale(Locale locale) {



    Get.updateLocale(locale);
  }

  static String get rightTriangle => 'right_triangle'.tr;
  static String get enterTwoParameters => 'enter_2_parameters'.tr;
  static String get enterOneParameters => 'enter_1_parameters'.tr;
  static String get appName => 'app_name'.tr;
  static String get appNameSub => 'app_name_sub'.tr;
  static String get about => 'about'.tr;

  static String get launch => 'launch'.tr;
  static String get settingFirstLaunch => 'setting_first_launch'.tr;
  static String get darkTheme => 'dark_theme'.tr;
  static String get lightTheme => 'light_theme'.tr;
  static String get setting => 'setting'.tr;
  static String get home => 'home'.tr;
  static String get shareApp => 'share_app'.tr;
  static String get shareDetails => 'share_details'.tr;
  static String get exit => 'exit'.tr;
  static String get exitWarning => 'exit_warning'.tr;
  static String get warning => 'warning'.tr;
  static String get yes => 'yes'.tr;
  static String get no => 'no'.tr;

  static String get showStartupScreen => 'show_startup_screen'.tr;
  static String get languageEn => 'language_en'.tr;
  static String get languageRu => 'language_ru'.tr;
  static String get language => 'language'.tr;
  static String get selectTheme => 'select_theme'.tr;
  static String get selectThemeLight => 'select_theme_light'.tr;
  static String get selectThemeDark => 'select_theme_dark'.tr;
  static String get messageAngleOver90 => 'message_angle_less_90'.tr;
  static String get selectedPrecisionResult => 'selected_precision_result'.tr;
  static String get messageEnterValueSides => 'enter_value_sides'.tr;
  static String get messageHypotenuseGreaterCathetus =>
      'message_hypotenuse_greater_cathetus'.tr;
}
