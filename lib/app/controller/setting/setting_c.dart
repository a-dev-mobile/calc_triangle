import 'package:calc_triangle/app/constant/const_color.dart';
import 'package:calc_triangle/app/constant/const_number.dart';
import 'package:calc_triangle/app/constant/const_string.dart';
import 'package:calc_triangle/app/services/serv_glob.dart';
import 'package:calc_triangle/app/utils/app_utils.dart';
import 'package:calc_triangle/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ContrSetting extends GetxController {
  static ContrSetting get to => ContrSetting();

  var precisionResult = ConstNumber.defPrecisionResult.obs;

  void setRusLocation() {
    ServGlob.to.appLocale.value = ConstString.localeRu;
  }

  void setEnLocation() {
    ServGlob.to.appLocale.value = ConstString.localeEn;
  }

  void setPrecisionResult(int precision) {
    if (precisionResult.value == precision) return;
    precisionResult.value = precision;
    printt.e('${precisionResult.value}');
    AppUtils.setPrecisionResult(precision);

    // RightTriangleController c = Get.find();

    // //вызов из другого контроллера для обновления точности результата расчета
    // c.precisionResult = precision;
    // c.calculate();
  }

  void setDarkTheme() {
    if (ServGlob.to.isDark.value == true) return;

    Get.changeThemeMode(ThemeMode.dark);
    ServGlob.to.setStorageIsDarkTheme(true);

    setThemeAppBar();
  }

  void setLightTheme() {
    if (ServGlob.to.isDark.value == false) return;

    Get.changeThemeMode(ThemeMode.light);
    ServGlob.to.setStorageIsDarkTheme(false);

    setThemeAppBar();
  }

  void setThemeAppBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarIconBrightness:
            ServGlob.to.isDark.value ? Brightness.light : Brightness.dark,
        statusBarColor: ServGlob.to.isDark.value
            ? ConstColor.scaffoldDarkTheme
            : ConstColor.scaffoldLightTheme, // Color for Android
        statusBarBrightness: ServGlob.to.isDark.value
            ? Brightness.dark
            : Brightness.light // Dark == white status bar -- for IOS.
        ));
  }

  @override
  void onInit() {
    precisionResult.value = AppUtils.getPrecisionResults().toInt();

    super.onInit();
  }
}
