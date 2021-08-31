// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:calc_triangle/controllers/r_triangle_c.dart';
import 'package:calc_triangle/localization/translate_helper.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import 'widget/image_info_w.dart';
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
      child: Column(
        children: [
          Obx(() {
            if (c.isInputImage.value) {
              return Container(
                child: ImageInputWidget(),
                margin: EdgeInsets.all(kDefaultMargin),
                decoration: BoxDecoration(
                    color: kBgColorContent,
                    borderRadius: BorderRadius.all(Radius.circular(32))),
              );
            } else {
              return Container(
                child: ImageInfoWidget(),
                margin: EdgeInsets.all(kDefaultMargin),
                decoration: BoxDecoration(
                    color: kBgColorContent,
                    borderRadius: BorderRadius.all(Radius.circular(32))),
              );
            }
          }),
          Container(
            margin: EdgeInsets.all(kDefaultMargin),
            width: 1.sw,
            height: 0.1.sh,
            decoration: BoxDecoration(
                color: kBgColorContent,
                borderRadius: BorderRadius.all(Radius.circular(32))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  TranslateHelper.rightTriangle,
                  style: TextStyle(fontSize: 60.sp),
                ),
                Divider(
                  color: kActivTextColor,
                ),
                Text(TranslateHelper.enterTwoParameters),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(kDefaultMargin),
              decoration: BoxDecoration(
                  color: kBgColorContent,
                  borderRadius: BorderRadius.all(Radius.circular(32))),
              child: NumPad(),
            ),
          ),
          Container(
            width: 1.sw,
            color: Colors.amber,
            height: 0.08.sh,
          )
        ],
      ),
    ));
  }
}
