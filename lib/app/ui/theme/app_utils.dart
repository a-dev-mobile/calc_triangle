import 'package:calc_triangle/app/constant/const.dart';
import 'package:calc_triangle/main.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

abstract class AppUtils {
  static bool isDark = GetStorage().read(ConstString.keyIsDarkTheme) ?? false;

  static BuildContext contex = MyApp.materialKey.currentContext!;
}
