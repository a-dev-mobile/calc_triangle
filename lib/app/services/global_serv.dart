import 'dart:io';

import 'package:calc_triangle/app/constant/const_string.dart';
import 'package:calc_triangle/app/utils/local_torage.dart';

import 'package:get/get.dart';



class GlobalServ extends GetxService {
  static GlobalServ get to => Get.find();

  RxInt precisionResult = 1.obs;

  var isDark = false.obs;
  var isFirstStartApp = false;
  var appLocale = ConstString.localeEn.obs;
  var isShowLaunchScreen = false.obs;

// ========================================
  void initStartTheme() {
    LocalStorage().setItemBool(ConstString.keyIsDarkTheme, false);
  }

  Future<void> getStorageTheme() async {
    isDark.value = await LocalStorage().getItemBool(ConstString.keyIsDarkTheme);
  }

  void setStorageIsDarkTheme(bool isDarkTheme) async {
    LocalStorage().setItemBool(ConstString.keyIsDarkTheme, isDarkTheme);
    isDark.value = isDarkTheme;
  }

// ========================================
  void initStartLocale() {
    appLocale.value = Platform.localeName == 'ru_RU'
        ? ConstString.localeRu
        : ConstString.localeEn;

    LocalStorage().setItemString(ConstString.keyLocale, appLocale.value);
  }

  Future<void> setStorageLocale(String locale) async {
    LocalStorage().setItemString(ConstString.keyLocale, locale);
    appLocale.value = locale;
  }

  Future<void> getStorageLocale() async {
    String locale = await LocalStorage().getItemString(ConstString.keyLocale);

    appLocale.value = locale;
  }
// ========================================

  void initFirstStartApp() async {
    isFirstStartApp =
        await LocalStorage().getItemBool(ConstString.keyFirstStartApp);
  }

  void setNonFirstStartApp() async {
    isFirstStartApp = false;
      await LocalStorage().setItemBool(ConstString.keyFirstStartApp, isFirstStartApp);

  }

// ========================================

  void changeShowLaunchScreen() async {
    isShowLaunchScreen.value = !(isShowLaunchScreen.value);
   LocalStorage().setItemBool(ConstString.keyShowLaunchScreen, isShowLaunchScreen.value);
 
  }

  Future<void> initSetStorageShowLaunchScreen() async {
    if (isFirstStartApp) {
      isShowLaunchScreen.value = true;
    }
  }

  void getStorageIsShowLaunchScreen() async{
    isShowLaunchScreen.value =
        await LocalStorage().getItemBool(ConstString.keyShowLaunchScreen);
    
  }

  void startOthe() async {
    getStorageTheme();
    getStorageLocale();
    getStorageIsShowLaunchScreen();
  }

  @override
  void onInit() {
    initFirstStartApp();
    initStartTheme();
    initStartLocale();
    initSetStorageShowLaunchScreen();
    startOthe();

    super.onInit();
  }
}
