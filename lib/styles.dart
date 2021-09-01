
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class StyleNumpad {
  static TextStyle function =
      TextStyle(color: const Color(0x80F50021), fontSize: 80.sp);
  static TextStyle operator =
      TextStyle(color: const Color(0x8083BFFF), fontSize: 150.sp);
  static TextStyle integer =
      TextStyle(color: const Color(0xffffffff), fontSize: 90.sp);
}

abstract class StyleDrawer {
  static TextStyle textAppName =
      TextStyle(color: const Color(0xff000000), fontSize: 80.sp);
  static TextStyle textAppNameSub =
      TextStyle(color: const Color(0xe6000000), fontSize: 60.sp);

  static TextStyle textItem =
      TextStyle(color: const Color(0xe6000000), fontSize: 60.sp);

  static const colorIcon = Color(0xffA0A0A0);
  static double sizeIcon = 120.sp;
}

abstract class StyleTextInfo {
  static TextStyle mainText =
      TextStyle(color: const Color(0xffffffff), fontSize: 60.sp);

  static TextStyle subText =
      TextStyle(color: const Color(0xffffffff), fontSize: 40.sp);
}

abstract class StyleTextImage {
  static TextStyle active = TextStyle(
      // backgroundColor: kColorContent,
      fontSize: 85.sp,
      color: const Color(0xFFF50021));

  static TextStyle inActive = TextStyle(
      // backgroundColor: kColorContent,
      fontSize: 75.sp,
      color: const Color(0xffffffff));
}
