import 'package:calc_triangle/app/constant/const_number.dart';
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

  static int getPrecisionResults() {
    var value = GetStorage().read(ConstString.keyPrecisionResult) ?? 3.0;
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

//==============================================
  static Future<void> setAciveShape(int index) async {
    await GetStorage().write(ConstString.keyActiveShape, index);
    printt.w('AppUtils setAciveShape  $index');
  }

  static int activeShapeIndex() {
    int index = GetStorage().read(ConstString.keyActiveShape) ?? 0;
    printt.w('AppUtils GetStorage activeShapeIndex $index');
    return index;
  }
//==============================================

  static double getImageMinSize() {
    double minSize = GetStorage().read(ConstString.keyMinSize) ?? 0;

    return minSize;
  }

  static Future<void> setImageMinSize(double size) async {
    GetStorage().write(ConstString.keyMinSize, size);
  }

  static BuildContext contex2 = MyApp.materialKey.currentContext!;
}

abstract class AppUtilsString {
  static String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  static String getFormatNumber(double value, int numberDigitsAfterPoint) {
    String s = value.toStringAsFixed(numberDigitsAfterPoint);
    RegExp regex = RegExp(r"([.]*0)(?!.*\d)");

    String s1 = '2.2121001';
 for(int i=0; i<s1.length; i++) {
print( s[i]);
}

    return s.replaceAll(regex, "");
  }

  static String removeLastCharacter(String str) {
    String result = '';
    if ((str != '') && (str.isNotEmpty)) {
      result = str.substring(0, str.length - 1);
    }

    // print('old $str new $result');
/* 
  
double num = 123.000;
      String s;
        String s2;
        String s3;
 s = num.toStringAsFixed(2); 
  
    RegExp regex = RegExp(r"([.]*0)(?!.*\d)");
 s= s.replaceAll(regex, "");
  
 s3 = s.split('.')[1];
    
  if(int.parse(s)>0){
    
    print('остаток >0');
  }
  
  
   s2 = num.toString().replaceAll(regex, "");

  print (s);
    print (s2);
  
  
    String s1 = '2.212100';
  
  s1 = s1.split('.')[1];
 for(int i=0; i<s1.length; i++) {
print( s1[i]);
   
}
  print(s1.substring(s1.length - 1));
}



 */
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
    printt.i('accuracy $i > $declaredAccuracy');

    if (i > declaredAccuracy) return true;

    return false;
  }
}
