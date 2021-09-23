import 'dart:io';

import 'package:calc_triangle/app/constant/const_string.dart';
import 'package:calc_triangle/app/utils/local_torage.dart';
import 'package:calc_triangle/app/utils/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class GlobalServ extends GetxService {
  static GlobalServ get to => Get.find();

  var isDarkTheme = false.obs;
  var isFirstStartApp = false;
  var appLocale = ConstString.localeEn.obs;
  var isShowLaunchScreen = false.obs;

// ========================================


  void setStorageIsDarkTheme(bool isDark) async {
    isDarkTheme.value = isDark;
  }

// ========================================
  void setDefaultLocale() {
    appLocale.value = Platform.localeName == 'ru_RU'
        ? ConstString.localeRu
        : ConstString.localeEn;
  }

  void setStorageLocale(String locale) {
    appLocale.value = locale;
  }

// ========================================
  void setNonFirstStartApp() async {
    isFirstStartApp = false;
  }

// ========================================

  void changeShowLaunchScreen() {
    isShowLaunchScreen.value = !isShowLaunchScreen.value;
  }

  @override
  void onInit() async {
        logger.d('onInit global service');
    bool isNullFirstStartApp =
        await LocalStorage().isNull(ConstString.keyIsFirstStartApp);
    // если первый запуск
    if (isNullFirstStartApp) {
      isFirstStartApp = true;
      isShowLaunchScreen.value = true;
      isDarkTheme.value = false;
      setDefaultLocale();
    } else {
      // устанавливаем если не первый запуск
      isShowLaunchScreen.value =
          await LocalStorage().getItemBool(ConstString.keyIsShowLaunchScreen);
      appLocale.value =
          await LocalStorage().getItemString(ConstString.keyLocaleApp);
      isDarkTheme.value =
          await LocalStorage().getItemBool(ConstString.keyIsDarkTheme);
    }

    super.onInit();
  }


}

class LifecycleEventHandler extends WidgetsBindingObserver {
  LifecycleEventHandler({required this.resumeCallBack, required this.suspendingCallBack});

  final AsyncCallback  resumeCallBack;
  final AsyncCallback  suspendingCallBack;

//  @override
//  Future<bool> didPopRoute()

//  @override
//  void didHaveMemoryPressure()

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
    case AppLifecycleState.resumed:
        await resumeCallBack();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        await suspendingCallBack();
        break;
    }
    log.e('''
=============================================================
               $state
=============================================================
''');
  }

//  @override
//  void didChangeLocale(Locale locale)

//  @override
//  void didChangeTextScaleFactor()

//  @override
//  void didChangeMetrics();

//  @override
//  Future<bool> didPushRoute(String route)
}


