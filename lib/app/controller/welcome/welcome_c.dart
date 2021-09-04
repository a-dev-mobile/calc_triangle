import 'package:calc_triangle/app/ui/theme/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';

class WelcomeController extends GetxController {
  final isDarkTheme = false.obs;

  _saveThemeToBox() {
    printt.i('is dark save ${isDarkTheme.value}');
    AppUtils.setIsDarkTheme(isDarkTheme.value);
  }

  // saveFirstStartToBox() => _box.write(ConstString.keyIsFirstStart, true);

  void switchTheme() {
    isDarkTheme.value = !isDarkTheme.value;
    isDarkTheme.value
        ? Get.changeThemeMode(ThemeMode.dark)
        : Get.changeThemeMode(ThemeMode.light);

    _saveThemeToBox();
  }

  @override
  void onInit() {
    AppUtils.setIsDarkTheme(isDarkTheme.value);
    super.onInit();
  }
}
