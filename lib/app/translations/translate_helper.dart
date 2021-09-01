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
  static String get appName => 'app_name'.tr;
  static String get appNameSub => 'app_name_sub'.tr;
  static String get about => 'about'.tr;
  static String get chooseTheme => 'choose_theme'.tr;
  static String get selectTheme => 'select_theme'.tr;
  
}
