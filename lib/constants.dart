import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const kPrimaryColor = Color(0xFF07DBF5);
const kBgColorMain = Color(0xFF191919);

const kColorImage = Color(0xffffffff);

const kActivTextColor = Color(0xFFF50021);
const kInActivTextColor = Color(0xffffffff);

const kBgColorContent = Color(0xFF1D1D35);

const kDefaultPadding = 20.0;
const kDefaultMargin = 5.0;

abstract class StyleNumpad {
  static TextStyle function =
      TextStyle(color: const Color(0x80F50021), fontSize: 80.sp);
  static TextStyle operator =
      TextStyle(color: const Color(0x8083BFFF), fontSize: 150.sp);
  static TextStyle integer =
      TextStyle(color: const Color(0xffffffff), fontSize: 90.sp);
}

// const kBgGradient = LinearGradient(
//     colors: [Color(0xFF2E2F38), Colors.black],
//     begin: Alignment.topCenter,
//     end: Alignment.bottomCenter,
//   );

// enum BtnTypeCalc { integer, function, operator }

// abstract class ConstColors {

//   static const colorImage = Colors.white;
//   static const numpadBg = Color(0xff262626);

// }

abstract class ConstGet {
  static const String minSize = 'minSize';
}
