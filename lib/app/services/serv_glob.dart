import 'dart:io';

import 'package:calc_triangle/app/constant/const_string.dart';
import 'package:calc_triangle/main.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ServGlob extends GetxService {
  static ServGlob get to => Get.find();

  var box = GetStorage();
  var isDark = false.obs;
  var isFirstStartApp = false;
  var appLocale = ConstString.localeEn.obs;
  var isShowLaunchScreen = false.obs;

// ========================================
  void initStartTheme() {
    box.writeIfNull(ConstString.keyIsDarkTheme, false);
  }

  void getStorageTheme() {
    isDark.value = box.read(ConstString.keyIsDarkTheme) ?? false;
    printt.w('GetStorage GetStorage isDark $isDark');
  }

  void setStorageIsDarkTheme(bool isDarkTheme) async {
    box.write(ConstString.keyIsDarkTheme, isDarkTheme);
    isDark.value = isDarkTheme;
    printt.w('GetStorage setIsDarkTheme  ${isDark.value}');
  }

// ========================================
  void initStartLocale() {
    appLocale.value = Platform.localeName == 'ru_RU'
        ? ConstString.localeRu
        : ConstString.localeEn;

    box.writeIfNull(ConstString.keyLocale, appLocale.value);
  }

  Future<void> setStorageLocale(String locale) async {
    await box.write(ConstString.keyLocale, locale);
    appLocale.value = locale;
    printt.w('AppUtils setLocale  ${appLocale.value}');
  }

  void getStorageLocale() {
    String locale = box.read(ConstString.keyLocale);
    printt.w('GetStorage getLocale $locale');
    appLocale.value = locale;
  }
// ========================================

  void initFirstStartApp() {
    isFirstStartApp = box.read(ConstString.keyFirstStartApp) ?? true;

    printt.w('GetStorage isFirstStartApp $isFirstStartApp');
  }

  void setNonFirstStartApp() async {
    isFirstStartApp = false;
    box.write(ConstString.keyFirstStartApp, isFirstStartApp);
    printt.w('GetStorage setFirstStartApp isFirstStartApp $isFirstStartApp');
  }

// ========================================

  void changeShowLaunchScreen() async {
    isShowLaunchScreen.value = !(isShowLaunchScreen.value);
    box.write(ConstString.keyShowLaunchScreen, isShowLaunchScreen.value);
    printt.w('GetStorage ShowLaunchScreen  ${isShowLaunchScreen.value}');
  }

  Future<void> initSetStorageShowLaunchScreen() async {
    if (isFirstStartApp) {
      isShowLaunchScreen.value = true;
    }
  }

  void getStorageIsShowLaunchScreen() {
    isShowLaunchScreen.value =
        box.read(ConstString.keyShowLaunchScreen) ?? false;
    printt.w('GetStorage isShowLaunchScreen false');
  }

  @override
  void onInit() {
    initFirstStartApp();
    initStartTheme();
    initStartLocale();
    initSetStorageShowLaunchScreen();
    
    getStorageTheme();
    getStorageLocale();
    getStorageIsShowLaunchScreen();
    super.onInit();
  }
}
