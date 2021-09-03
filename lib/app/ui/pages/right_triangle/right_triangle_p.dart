// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:calc_triangle/app/constant/const.dart';
import 'package:calc_triangle/app/controller/right_triangle/right_triangle_c.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';
import 'package:calc_triangle/app/ui/theme/app_color.dart';
import 'package:calc_triangle/app/ui/theme/app_style.dart';
import 'package:calc_triangle/app/ui/widgets/drawer/drawer_icon_w.dart';
import 'package:calc_triangle/app/ui/widgets/drawer/drawer_w.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'widget/r_triangle_image_info_w.dart';
import 'widget/r_triangle_image_input_w.dart';
import 'widget/numpad_w.dart';

enum RightTriangelElement {
  aCathet,
  bCathet,
  cHypotenuse,
  aAngle,
  bAngle,
}

class RighTrianglePage extends GetView<RightTriangleController> {
  RighTrianglePage({Key? key}) : super(key: key);
  static const maxSelected = 2;
  static const maxValue = 5;

  static const startElement = RightTriangelElement.aCathet;
  final GlobalKey<ScaffoldState> _globalkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var c = controller;

    Widget imageFigure;
    return Scaffold(
        key: _globalkey,
        drawer: DrawerWidget(),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Obx(() {
                    // рисунок фигуры
                    c.isInputImage.value
                        ? imageFigure = RightTriangleImageInputWidget()
                        : imageFigure = RightTriangleImageInfoWidget();

                    return Container(
                      child: imageFigure,
                      margin: EdgeInsets.all(ConstDefaultDouble.margin),
                      decoration: BoxDecoration(
                          color: AppColors.content(context),
                          borderRadius: BorderRadius.all(
                              Radius.circular(ConstDefaultDouble.radius))),
                    );
                  }),
                  Container(
                    margin: EdgeInsets.all(ConstDefaultDouble.margin),
                    width: 1.sw,
                    height: 0.1.sh,
                    decoration: BoxDecoration(
                        color: AppColors.content(context),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ConstDefaultDouble.radius))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          TranslateHelper.rightTriangle,
                          style: AppStyleTextInfo.mainText,
                        ),
                        Divider(
                          color: Colors.white,
                        ),
                        Text(
                          TranslateHelper.enterTwoParameters,
                          style: AppStyleTextInfo.subText,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(ConstDefaultDouble.margin),
                      decoration: BoxDecoration(
                          color: AppColors.content(context),
                          borderRadius: BorderRadius.all(
                              Radius.circular(ConstDefaultDouble.radius))),
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
              DrawerIconWidget(globalkey: _globalkey)
            ],
          ),
        ));
  }
}
