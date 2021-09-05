import 'package:calc_triangle/app/constant/const.dart';
import 'package:calc_triangle/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

abstract class AppUtils {
  static bool isDark() {
    bool isDark = GetStorage().read(ConstString.keyIsDarkTheme) ?? false;
    printt.v('AppUtils GetStorage isDark $isDark');
    return isDark;
  }

  static Future<void> setIsDarkTheme(bool isDark) async {
    await GetStorage().write(ConstString.keyIsDarkTheme, isDark);
    printt.v('AppUtils setIsDarkTheme  ${AppUtils.isDark()}');
  }

  static double getImageMinSize() {
    double minSize = GetStorage().read(ConstString.keyMinSize) ?? 0;

    return minSize;
  }

  static Future<void> setImageMinSize(double size) async {
    GetStorage().write(ConstString.keyMinSize, size);
  }

  static BuildContext contex2 = MyApp.materialKey.currentContext!;
}
