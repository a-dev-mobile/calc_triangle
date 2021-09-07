import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppWidget {
  static Widget dividerWelcome() {
    return Divider(
      color: Colors.grey,
      height: 30.h,
      indent: 50.w,
      endIndent: 50.w,
    );
  }

  static Widget dividerDrawer() {
    return Divider(
      color: Colors.grey,
      height: 30.h,
      indent: 20.w,
      endIndent: 20.w,
    );
  }
}
