import 'dart:io';

import 'package:calc_triangle/app/constants/const_bool.dart';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return ConstBool.isDebug
          ? 'ca-app-pub-3940256099942544/6300978111' //test
          : 'ca-app-pub-6155876762943258/4979500642';
    } else if (Platform.isIOS) {
      return ConstBool.isDebug
          ? 'ca-app-pub-3940256099942544/2934735716' //test
          : 'ca-app-pub-6155876762943258/3399853330';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return ConstBool.isDebug
          ? 'ca-app-pub-3940256099942544/1033173712' //test
          : "ca-app-pub-6ç155876762943258/3893136337";
    } else if (Platform.isIOS) {
      return ConstBool.isDebug
          ? 'ca-app-pub-3940256099942544/4411468910' //test
          : "ca-app-pub-6155876762943258/7549481750";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
