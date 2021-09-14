import 'dart:io';

import 'package:calc_triangle/app/constant/const_bool.dart';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return ConstBool.isDebug
          ? 'ca-app-pub-3940256099942544/6300978111' //test
          : 'ca-app-pub-6155876762943258/4979500642';
    } else if (Platform.isIOS) {
      return ConstBool.isDebug
          ? 'ca-app-pub-3940256099942544/2934735716'//test
          : 'ca-app-pub-6155876762943258/3399853330';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}