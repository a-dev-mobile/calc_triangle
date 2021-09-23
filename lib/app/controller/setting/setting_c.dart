import 'package:calc_triangle/app/constant/const_color.dart';
import 'package:calc_triangle/app/constant/const_number.dart';
import 'package:calc_triangle/app/constant/const_string.dart';
import 'package:calc_triangle/app/services/global_serv.dart';

import 'package:calc_triangle/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingContrl extends GetxController {
  static SettingContrl get to => SettingContrl();

RxInt  precisionResult = 2.obs;

  void setRusLocation() {
    GlobalServ.to.appLocale.value = ConstString.localeRu;
  }

  void setEnLocation() {
    GlobalServ.to.appLocale.value = ConstString.localeEn;
  }

  void setPrecisionResult(int precision) {
    // if (precisionResult.value == precision) return;
    precisionResult.value = precision;
    printt.e('setPrecisionResult ${precisionResult.value}');
   setStoragePrecisionResult(precision);

    // RightTriangleController c = Get.find();

    // //вызов из другого контроллера для обновления точности результата расчета
    // c.precisionResult = precision;
    // c.calculate();
  }

  // =====================================
  int getStoragePrecisionResults() {
    var value =GetStorage().read(ConstString.keyPrecisionResult) ?? 1.0;
    printt.w('AppUtils GetStorage getPrecisionResults $value');

    return value.toInt();
  }

  Future<void> setStoragePrecisionResult(int value) async {
    await GetStorage().write(ConstString.keyPrecisionResult, value);
    printt.w('AppUtils setPrecisionResult  ${getStoragePrecisionResults()}');
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
  void onInit() {
    precisionResult.value = SettingContrl.to.getStoragePrecisionResults().toInt();

    super.onInit();
  }
}
