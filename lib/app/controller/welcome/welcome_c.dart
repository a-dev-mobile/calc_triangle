import 'package:calc_triangle/app/constant/string_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WelcomeController extends GetxController {
  final isDarkTheme = false.obs;

  final _box = GetStorage();

  void _readFromBox() {
    isDarkTheme.value = _box.read(StringConst.kKeyIsDarkTheme) ?? false;
  }

  _saveThemeToBox() {
    print('is dark save ${isDarkTheme.value}');
    _box.write(StringConst.kKeyIsDarkTheme, isDarkTheme.value);
  }

  saveFirstStartToBox() => _box.write(StringConst.kKeyIsFirstStart, true);

  void swithTheme() {
    isDarkTheme.value = !isDarkTheme.value;
    isDarkTheme.value
        ? Get.changeThemeMode(ThemeMode.dark)
        : Get.changeThemeMode(ThemeMode.light);

    _saveThemeToBox();
  }

  @override
  void onInit() {
    _readFromBox();
    super.onInit();
  }
}
