import 'package:calc_triangle/app/constants/const_string.dart';
import 'package:calc_triangle/app/utils/local_torage.dart';

import 'package:flutter/material.dart';

class AppUtils {
  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  //==============================================

  //==============================================

  static Future<double> getImageMinSize() async {
    double minSize = await LocalStorage().getItemDouble(ConstString.keyMinSize);

    return minSize;
  }

  static void setImageMinSize(double size) {
    LocalStorage().setItemDouble(ConstString.keyMinSize, size);
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

  static String addZeroIsFirstDecimal(String text) {
    if (AppUtilsString.getFirstCharacter(text) == '.') {
      return text = '0$text';
    } else {
      return text;
    }
  }
}

class AppUtilsNumber {
  static String getFormatNumber(double num, int numberDigitsAfterPoint) {
    // округляем, но нет удаления конечных нулей
    String num2 = num.toStringAsFixed(numberDigitsAfterPoint);
    // если нет точки возвращаем
    if (!num2.contains('.')) return num2;

    List<String> s = num2.split('.');
    String mainResult = num2;
    // проверяем есть ли последние нули
    if (AppUtilsString.getLastCharacter(s[1]) == '0') {
      String oldString = '';
      String newString = '';
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
        mainResult = '${s[0]}.$newString';
      }
    }

    return mainResult;
  }
}
