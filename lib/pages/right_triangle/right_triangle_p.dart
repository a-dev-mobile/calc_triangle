// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:math';

import 'package:calc_triangle/controllers/r_triangle_c.dart';
import 'package:calc_triangle/pages/right_triangle/widget/a_angle_w.dart';
import 'package:calc_triangle/pages/right_triangle/widget/a_cathet_w.dart';
import 'package:calc_triangle/pages/right_triangle/widget/b_angle.dart';
import 'package:calc_triangle/pages/right_triangle/widget/b_cathet_w.dart';
import 'package:calc_triangle/pages/right_triangle/widget/c_hypotenusea_w.dart';
import 'package:calc_triangle/pages/right_triangle/widget/image_info_w.dart';
import 'package:calc_triangle/utils/key_symbol.dart';

import 'package:calc_triangle/utils/calculator_key.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';

import '../../../const.dart';
import 'widget/image_input_w.dart';
import 'widget/numpad_w.dart';

enum RightTriangelElement {
  aCathet,
  bCathet,
  cHypotenuse,
  aAngle,
  bAngle,
}

class RighTrianglePage extends StatelessWidget {
  const RighTrianglePage({Key? key}) : super(key: key);

  static const maxSelected = 2;
  static const maxValue = 5;

  static const startElement = RightTriangelElement.aCathet;
  static const startValue = '000';

  @override
  Widget build(BuildContext context) {
    RtriangleController c = Get.find();
    print('build stack');

    var size = MediaQuery.of(context).size;
    var w = size.width;
    var h = size.height;
    print('w $w h $h');

    return Scaffold(
        body: SafeArea(
      child: Container(
        width: 1.sw,
        height: 1.sh,
        decoration: BoxDecoration(gradient: ConstColors.bgGradient),
        child: Column(
          children: [
            Obx(() {
              if (c.isInputImage.value) {
                return Container(
                  child: ImageInputWidget(),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: ConstColors.numpadBg,
                      borderRadius: BorderRadius.all(Radius.circular(32))),
                );
              } else {
            return Container(
                  child: ImageInfoWidget(),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: ConstColors.numpadBg,
                      borderRadius: BorderRadius.all(Radius.circular(32))),
                );
              }
            }),
            Container(
              margin: EdgeInsets.all(8),
              width: 1.sw,
              height: 0.2.sh,
              decoration: BoxDecoration(
                  color: ConstColors.numpadBg,
                  borderRadius: BorderRadius.all(Radius.circular(32))),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: ConstColors.numpadBg,
                    borderRadius: BorderRadius.all(Radius.circular(32))),
                child: NumPad(),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
