import 'package:calc_triangle/app/ui/theme/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class WelcomeController extends GetxController {
  final isDarkTheme = false.obs;

  // saveFirstStartToBox() => _box.write(ConstString.keyIsFirstStart, true);


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
    //инициализация перед запуском и правильное отображение  isDarkTheme.value
    isDarkTheme.value = AppUtils.isDark();
    super.onInit();
  }
}
