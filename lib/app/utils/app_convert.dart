import 'dart:math';

import 'package:calc_triangle/app/utils/app_utils.dart';

class AppConvert{


  static String convertStringToDouble(String strAmount) {
    try {
      double.tryParse(strAmount);

      return double.parse(strAmount).toString();
    } catch (e) {
      return "0";
    }
  }


  static double toRadian(double degree) {
    return degree * (pi / 180);
  }

  static double toDegree(double radian) {
    return radian * (180 / pi);
  }

  static String convertDMStoDeg(String dms, int precisionResults) {
    if (!dms.contains('°') && !dms.contains('′') && !dms.contains('″′')) {
      return 'error';
    }

    var dmsList = dms.split('°');
    double deg = double.parse(dmsList[0]);
    dmsList = dmsList[1].split('′');
    double min = double.parse(dmsList[0]);
    dmsList = dmsList[1].split('″');
    double sec = double.parse(dmsList[0]);

    return AppUtilsNumber.getFormatNumber(
            deg + (min / 60) + (sec / 3600), precisionResults) +
        "°";
  }

  static String convertDegToDMS(double degree, int precisionResults) {
    int d = degree.toInt();

    int m = ((degree - d) * 60).toInt();

    String s = AppUtilsNumber.getFormatNumber((degree - d - m / 60) * 3600, precisionResults);

    return '$d°$m′$s″';
  }
}