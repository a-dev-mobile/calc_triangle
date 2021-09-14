import 'dart:math';

import 'package:calc_triangle/app/constant/const_string.dart';
import 'package:calc_triangle/main.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

abstract class AppUtils {
  static bool isDark() {
    bool isDark = GetStorage().read(ConstString.keyIsDarkTheme) ?? false;
    printt.w('AppUtils GetStorage isDark $isDark');
    return isDark;
  }

  static bool isFirstStartApp() {
    bool isFirstStartApp =
        GetStorage().read(ConstString.keyFirstStartApp) ?? true;
    printt.w('AppUtils GetStorage isFirstStartApp $isFirstStartApp');
    return isFirstStartApp;
  }

  static String getLocale() {
    String locale =
        GetStorage().read(ConstString.keyLocale) ?? ConstString.localeEn;
    printt.w('AppUtils getLocale $locale');
    return locale;
  }

  static Future<void> setLocale(String locale) async {
    await GetStorage().write(ConstString.keyLocale, locale);
    printt.w('AppUtils setLocale  ${AppUtils.getLocale()}');
  }

  static Future<void> setFirstStartApp(bool isFirstStartApp) async {
    await GetStorage().write(ConstString.keyFirstStartApp, isFirstStartApp);
    printt.w('AppUtils setFirstStartApp  ${AppUtils.isFirstStartApp()}');
  }

  static bool isShowLaunchScreen() {
    bool isShowLaunchScreen =
        GetStorage().read(ConstString.keyShowLaunchScreen) ?? false;
    printt.w('AppUtils GetStorage isShowLaunchScreen $isShowLaunchScreen');
    return isShowLaunchScreen;
  }

  static Future<void> setShowLaunchScreen(bool isShowFirstSettingPage) async {
    await GetStorage()
        .write(ConstString.keyShowLaunchScreen, isShowFirstSettingPage);
    printt.w('AppUtils setShowFirstSetting  ${AppUtils.isShowLaunchScreen()}');
  }

  static int getPrecisionResults() {
    var value = GetStorage().read(ConstString.keyPrecisionResult) ?? 1.0;
    printt.w('AppUtils GetStorage getPrecisionResults $value');

    return value.toInt();
  }

  static Future<void> setIsDarkTheme(bool isDark) async {
    await GetStorage().write(ConstString.keyIsDarkTheme, isDark);
    printt.w('AppUtils setIsDarkTheme  ${AppUtils.isDark()}');
  }

  static Future<void> setPrecisionResult(int value) async {
    await GetStorage().write(ConstString.keyPrecisionResult, value);
    printt.w('AppUtils setPrecisionResult  ${AppUtils.getPrecisionResults()}');
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

//==============================================

//==============================================

  static double getImageMinSize() {
    double minSize = GetStorage().read(ConstString.keyMinSize) ?? 0;

    return minSize;
  }

  static Future<void> setImageMinSize(double size) async {
    GetStorage().write(ConstString.keyMinSize, size);
  }
}

abstract class AppUtilsString {
  static String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  static String removeLastCharacter(String str) {
    String result = '';
    if ((str != '') && (str.isNotEmpty)) {
      result = str.substring(0, str.length - 1);
    }

    return result;
  }

  static String getLastCharacter(String str) {
    String result = '';
    if ((str != '') && (str.isNotEmpty)) {
      result = str.substring(str.length - 1);
    }

    return result;
  }

  static String getFirstCharacter(String str) {
    String result = '';
    if ((str != '') && (str.isNotEmpty)) {
      result = str.substring(0);
    }

    return result;
  }

  static bool isTwoDecimalPoint(String text) {
    var i = text.split('.').length;
    if (i > 2) {
      return true;
    } else {
      return false;
    }
  }

  static String addZeroIsFirstDecimal(String text) {
    if (AppUtilsString.getFirstCharacter(text) == '.') {
      return text = '0' + text;
    } else {
      return text;
    }
  }

  static bool isMoreAccuracy(String value, int declaredAccuracy) {
    //если не содержит точку то возврат
    if (!value.contains('.')) return false;

    int i = value.length - (value.toString().indexOf('.') + 1);
    // printt.i('accuracy $i > $declaredAccuracy');

    if (i > declaredAccuracy) return true;

    return false;
  }
}

abstract class AppUtilsNumber {
  static String getFormatNumber(double num, int numberDigitsAfterPoint) {
// округляем, но нет удаления конечных нулей
    String num2 = num.toStringAsFixed(numberDigitsAfterPoint);
    // если нет точки возвращаем
    if (!num2.contains('.')) return num2;

    var s = num2.split('.');
    String mainResult = num2;
    // проверяем есть ли последние нули
    if (AppUtilsString.getLastCharacter(s[1]) == '0') {
      String oldString = "";
      String newString = "";
      oldString = s[1];

      for (int i = 0; i < s[1].length; i++) {
        if (AppUtilsString.getLastCharacter(oldString) == '0') {
          newString = AppUtilsString.removeLastCharacter(oldString);
        } else {
          break;
        }
        oldString = newString;
      }
// действия, если после ни чего ни осталось оставляем split 0
      if (newString.isEmpty) {
        mainResult = s[0];
      } else {
        mainResult = s[0] + "." + newString;
      }
    }

    return mainResult;
  }

  static double toRadian(double degree) {
    return degree * (pi / 180);
  }

  static double toDegree(double radian) {
    return radian * (180 / pi);
  }

  static bool isDoublesNanAndInfinity(List<double> listDouble) {
    for (var item in listDouble) {
      if (item.isNaN || item.isInfinite) {
        return true;
      }
    }
    return false;
  }

  static String convertDMStoDeg(String dms,int precisionResults) {
    if (!dms.contains('°') && !dms.contains('′') && !dms.contains('″′')) {
      return 'error';
    }

    var dmsList = dms.split('°');
    double deg = double.parse(dmsList[0]);
    dmsList = dmsList[1].split('′');
    double min = double.parse(dmsList[0]);
    dmsList = dmsList[1].split('″');
    double sec = double.parse(dmsList[0]);

    return AppUtilsNumber.getFormatNumber(deg + (min / 60) + (sec / 3600),precisionResults)+"°";
  }

  static String convertDegToDMS(double degree, int precisionResults) {
    int d = degree.toInt();

    int m = ((degree - d) * 60).toInt();

    String s = getFormatNumber((degree - d - m / 60) * 3600, precisionResults);

    return '$d°$m′$s″';
  }
}
