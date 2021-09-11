import 'package:calc_triangle/app/translations/translate_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TranslateHelper.setting),
      ),
      body: Placeholder(
        fallbackHeight: 1.sh,
        fallbackWidth: 1.sw,
      ),
    );
  }
}
