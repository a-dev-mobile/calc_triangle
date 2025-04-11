import 'dart:io';

import 'package:calc_triangle/app/constants/const_number.dart';
import 'package:calc_triangle/app/constants/const_string.dart';
import 'package:calc_triangle/app/features/select_shape/select_shape_p.dart';
import 'package:calc_triangle/app/utils/local_torage.dart';
import 'package:calc_triangle/app/utils/logger.dart';

import 'package:get/get.dart';

class GlobalServ extends GetxService {
  static GlobalServ get to => Get.find();

  RxBool isDarkTheme = false.obs;
  // Keep this for backward compatibility but it's not used anymore
  bool isFirstStartApp = false;
  RxString appLocale = ConstString.localeEn.obs;
  // Keep isShowLaunchScreen for backward compatibility with SettingLaunchScreenWidget
  RxBool isShowLaunchScreen = false.obs;

  // Precision for calculations
  RxInt precisionResult = ConstNumber.defPrecisionResult.obs;
  late Shape aciveShape;
  // ========================================
  Rx<Shape> activeShape = Shape.none.obs;

  // Add these methods
  void saveActiveShape(Shape shape) {
    activeShape.value = shape;
    LocalStorage().setItemInt(ConstString.keyActiveShape, shape.index);
    log.i('Saved active shape: $shape');
  }

  void restoreActiveShape() async {
    bool exists = await LocalStorage().isNull(ConstString.keyActiveShape);
    if (!exists) {
      int shapeIndex = await LocalStorage().getItemInt(
        ConstString.keyActiveShape,
      );
      if (shapeIndex >= 0 && shapeIndex < Shape.values.length) {
        activeShape.value = Shape.values[shapeIndex];
        log.i('Restored active shape: ${activeShape.value}');
      }
    }
  }

  void setStorageIsDarkTheme(bool isDark) async {
    isDarkTheme.value = isDark;
    LocalStorage().setItemBool(ConstString.keyIsDarkTheme, isDark);
  }

  // ========================================
  void setDefaultLocale() {
    appLocale.value =
        Platform.localeName == 'ru_RU'
            ? ConstString.localeRu
            : ConstString.localeEn;
  }

  void setStorageLocale(String locale) {
    appLocale.value = locale;
    LocalStorage().setItemString(ConstString.keyLocaleApp, locale);
  }

  // ========================================
  void setPrecisionResult(int precision) {
    precisionResult.value = precision;
    LocalStorage().setItemInt(ConstString.keyPrecisionResult, precision);
  }

  // Keep this method for backwards compatibility
  void startIfCloseSetiing() async {
    saveAllSettings();
  }

  // Updates all settings in storage
  void saveAllSettings() {
    LocalStorage().setItemString(ConstString.keyLocaleApp, appLocale.value);
    LocalStorage().setItemBool(ConstString.keyIsDarkTheme, isDarkTheme.value);
    LocalStorage().setItemInt(
      ConstString.keyPrecisionResult,
      precisionResult.value,
    );
  }

  @override
  void onInit() async {
    logger.d('onInit global service');

    // Always treat as not first start
    isFirstStartApp = false;

    // Restore active shape
    restoreActiveShape();

    String locale = await LocalStorage().getItemString(
      ConstString.keyLocaleApp,
      Platform.localeName == 'ru_RU'
          ? ConstString.localeRu
          : ConstString.localeEn,
    );
    appLocale.value = locale;

    bool isDark = await LocalStorage().getItemBool(
      ConstString.keyIsDarkTheme,
      false,
    );
    isDarkTheme.value = isDark;

    int precision = await LocalStorage().getItemInt(
      ConstString.keyPrecisionResult,
      ConstNumber.defPrecisionResult,
    );
    precisionResult.value = precision;

    super.onInit();
  }
}
