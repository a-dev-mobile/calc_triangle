import 'package:calc_triangle/app/constant/const_color.dart';
import 'package:calc_triangle/app/constant/const_number.dart';
import 'package:calc_triangle/app/constant/const_string.dart';
import 'package:calc_triangle/app/services/global_serv.dart';
import 'package:calc_triangle/app/utils/local_torage.dart';
import 'package:calc_triangle/app/utils/logger.dart';

import 'package:calc_triangle/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class SettingContrl extends GetxController {
  static SettingContrl get to => Get.find();

  RxInt precisionResult = 2.obs;

  void setRusLocation() {
    GlobalServ.to.appLocale.value = ConstString.localeRu;
  }

  void setEnLocation() {
    GlobalServ.to.appLocale.value = ConstString.localeEn;
  }

  void setPrecisionResult(int precision) {
    // if (precisionResult.value == precision) return;
    precisionResult.value = precision;
    log.e('setPrecisionResult ${precisionResult.value}');
    setStoragePrecisionResult(precision);

    // RightTriangleController c = Get.find();

    // //вызов из другого контроллера для обновления точности результата расчета
    // c.precisionResult = precision;
    // c.calculate();
  }

  // =====================================
  Future<int> getStoragePrecisionResults() async {
     var value = await LocalStorage().getItemInt(ConstString.keyPrecisionResult);
    precisionResult.value = value;
    return value.toInt();
  }

  Future<void> setStoragePrecisionResult(int value) async {
    await LocalStorage().setItemInt(ConstString.keyPrecisionResult, value);


  }

  // =====================================
  void setDarkTheme() {
    if (GlobalServ.to.isDark.value == true) return;

    Get.changeThemeMode(ThemeMode.dark);
    GlobalServ.to.setStorageIsDarkTheme(true);

    setThemeAppBar();
  }

  void setLightTheme() {
    if (GlobalServ.to.isDark.value == false) return;

    Get.changeThemeMode(ThemeMode.light);
    GlobalServ.to.setStorageIsDarkTheme(false);

    setThemeAppBar();
  }

  void setThemeAppBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarIconBrightness:
            GlobalServ.to.isDark.value ? Brightness.light : Brightness.dark,
        statusBarColor: GlobalServ.to.isDark.value
            ? ConstColor.scaffoldDarkTheme
            : ConstColor.scaffoldLightTheme, // Color for Android
        statusBarBrightness: GlobalServ.to.isDark.value
            ? Brightness.dark
            : Brightness.light // Dark == white status bar -- for IOS.
        ));
  }

  @override
  Future<void> onInit() async {
    precisionResult.value = await LocalStorage().getItemInt(ConstString.keyPrecisionResult);

    super.onInit();
  }
}
