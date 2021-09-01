import 'package:calc_triangle/localization/translate_helper.dart';
import 'package:flutter/material.dart';

class ColorChangePage extends StatelessWidget {
  const ColorChangePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Spacer(),
              Text(TranslateHelper.selectTheme),
            ],
          ),
        ),
      ),
    );
  }
}
