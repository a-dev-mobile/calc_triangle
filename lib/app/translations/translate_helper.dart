// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TranslateHelper {
  // он предназначен для предотвращения создания экземпляра TranslateHelper
  TranslateHelper._();
  static updateLocale(Locale locale) {
    Get.updateLocale(locale);
  }

  static String get right_triangle => 'right_triangle'.tr;
  static String get scalene_triangle => 'scalene_triangle'.tr;
  static String get enterThreeParameters => 'enter_3_parameters'.tr;
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
  static String get rateApp => 'rate_app'.tr;
  static String get feedback => 'feedback'.tr;

  static String get showStartupScreen => 'show_startup_screen'.tr;
  static String get languageEn => 'language_en'.tr;
  static String get languageRu => 'language_ru'.tr;
  static String get language => 'language'.tr;
  static String get selectTheme => 'select_theme'.tr;
  static String get selectThemeLight => 'select_theme_light'.tr;
  static String get selectThemeDark => 'select_theme_dark'.tr;
  static String get messageAngleOver90 => 'message_angle_less_90'.tr;
  static String get messageAngleOver180 => 'message_angle_less_180'.tr;
  static String get selectedPrecisionResult => 'selected_precision_result'.tr;
  static String get messageEnterAnyLength => 'message_enter_any_length'.tr;
  static String get messageHypotenuseGreaterCathetus =>
      'message_hypotenuse_greater_cathetus'.tr;

  static String get messageFormulaNotFound => 'message_formula_not_found'.tr;
  static String get message_max_number_entered => 'message_max_number_entered'.tr;
  static String get message_calc_error_chang_value => 'message_calc_error_chang_value'.tr;
  static String get perimeter => 'perimeter'.tr;
  static String get area => 'area'.tr;
  static String get chooseShape => 'choose_shape'.tr;

  static String get one_parameter_entered => 'one_parameters_entered'.tr;
  static String get two_parameters_entered => 'two_parameters_entered'.tr;
  static String get three_parameters_entered => 'three_parameters_entered'.tr;
  static String get you_calculate => 'you_calculate'.tr;

  static String get dialog_calculate => 'dialog_calculate'.tr;

  static String get sides_height_angles => 'sides_height_angles'.tr;
  static String get check_result => 'check_result'.tr;
}
