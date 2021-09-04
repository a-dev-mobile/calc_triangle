import 'package:calc_triangle/app/constant/const.dart';
import 'package:calc_triangle/main.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

abstract class AppUtils {
  static bool isDark = GetStorage().read(ConstString.keyIsDarkTheme);

  static void setIsDarkTheme(bool isDark) {
    GetStorage().write(ConstString.keyIsDarkTheme, isDark);
    printt.v('GetStorage isDark ${AppUtils.isDark}');
  }

  static double getImageMinSize() {
    var minSize = GetStorage().read(ConstString.keyMinSize) ?? 0;

    return minSize;
  }

  static void setImageMinSize(double size) {
    GetStorage().write(ConstString.keyMinSize, size);
  }

  static BuildContext contex = MyApp.materialKey.currentContext!;
}
