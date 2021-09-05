import 'package:calc_triangle/app/constant/const.dart';
import 'package:calc_triangle/app/ui/theme/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../main.dart';

class WelcomeController extends GetxController {
  final isDarkTheme = false.obs;

  // saveFirstStartToBox() => _box.write(ConstString.keyIsFirstStart, true);

  void switchTheme() {
    isDarkTheme.value = !isDarkTheme.value;
    isDarkTheme.value
        // ? Get.changeTheme(ThemeData.dark())
        //     : Get.changeTheme(ThemeData.light());
        ? Get.changeThemeMode(ThemeMode.dark)
        : Get.changeThemeMode(ThemeMode.light);

    AppUtils.setIsDarkTheme(isDarkTheme.value);
  }

  @override
  void onInit() {
    //инициализация перед запуском и правильное отображение  isDarkTheme.value
    isDarkTheme.value = AppUtils.isDark();
    super.onInit();
  }
}
