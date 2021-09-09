import 'package:calc_triangle/app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  var isDarkTheme = false.obs;

  // saveFirstStartToBox() => _box.write(ConstString.keyIsFirstStart, true);
  RxInt precisionResult = 3.obs;

  void setPrecisionResult(int precision) {
    if (precisionResult.value == precision) return;
    precisionResult.value = precision;

    AppUtils.setPrecisionResult(precision);
  }

  void setDarkTheme() {
    if (isDarkTheme.value == true) return;

    Get.changeThemeMode(ThemeMode.dark);
    isDarkTheme.value = true;

    AppUtils.setIsDarkTheme(isDarkTheme.value);
  }

  void setLightTheme() {
    if (isDarkTheme.value == false) return;

    Get.changeThemeMode(ThemeMode.light);
    isDarkTheme.value = false;

    AppUtils.setIsDarkTheme(isDarkTheme.value);
  }

  @override
  void onInit() {
    //инициализация перед запуском и правильное отображение
    isDarkTheme.value = AppUtils.isDark();
    precisionResult.value = AppUtils.getPrecisionResults().toInt();
    super.onInit();
  }
}
