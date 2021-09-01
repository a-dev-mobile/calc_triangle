import 'package:calc_triangle/app/controller/color_change/color_change_c.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorChangePage extends GetView<ColorChangeController> {
  const ColorChangePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var c = controller;
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
      
            Obx(() {
              print(
                  'build ColorChangePage isDarkTheme =  ${controller.isDarkTheme}');
              return Switch(
                  value: c.isDarkTheme.value, onChanged: (value) => c.toggle());
            }),
            Text(TranslateHelper.selectTheme),
          ],
        ),
      ),
    );
  }
}
