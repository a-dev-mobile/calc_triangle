import 'package:calc_triangle/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class StyleNumpad {
  static TextStyle function = GoogleFonts.montserrat(
      textStyle: TextStyle(color: const Color(0x80F50021), fontSize: 80.sp));
  static TextStyle operator = GoogleFonts.montserrat(
      textStyle: TextStyle(color: const Color(0x8083BFFF), fontSize: 150.sp));
  static TextStyle integer = GoogleFonts.montserrat(
      textStyle: TextStyle(color: const Color(0xffffffff), fontSize: 90.sp));
}

abstract class StyleDrawer {
  static TextStyle textAppName =
      TextStyle(color: const Color(0xff000000), fontSize: 80.sp);
  static TextStyle textAppNameSub =
      TextStyle(color: const Color(0xe6000000), fontSize: 60.sp);

  static TextStyle textItem = GoogleFonts.montserrat(
      textStyle: TextStyle(color: const Color(0xe6000000), fontSize: 60.sp));

  static const colorIcon = Color(0xffA0A0A0);
  static double sizeIcon = 120.sp;
}

abstract class StyleTextInfo {
  static TextStyle mainText = GoogleFonts.montserrat(
      textStyle: TextStyle(color: const Color(0xffffffff), fontSize: 60.sp));

  static TextStyle subText = GoogleFonts.montserrat(
      textStyle: TextStyle(color: const Color(0xffffffff), fontSize: 40.sp));
}

abstract class StyleTextImage {
  static TextStyle active = GoogleFonts.lato(
      textStyle: TextStyle(
          backgroundColor: kBgColorContent,
          fontSize: 85.sp,
          color: const Color(0xFFF50021)));

  static TextStyle inActive = GoogleFonts.lato(
      textStyle: TextStyle(
          backgroundColor: kBgColorContent,
          fontSize: 75.sp,
          color: const Color(0xffffffff)));
}
