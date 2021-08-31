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
}
