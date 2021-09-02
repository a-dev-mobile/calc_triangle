// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:calc_triangle/app/controller/r_triangle/r_triangle_c.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';
import 'package:calc_triangle/app/ui/theme/app_color_style.dart';
import 'package:calc_triangle/app/ui/widgets/drawer_w.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../styles.dart';
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

class RighTrianglePage extends StatefulWidget {
  const RighTrianglePage({Key? key}) : super(key: key);
  static const maxSelected = 2;
  static const maxValue = 5;

  static const startElement = RightTriangelElement.aCathet;

  @override
  State<RighTrianglePage> createState() => _RighTrianglePageState();
}

class _RighTrianglePageState extends State<RighTrianglePage> {
  final GlobalKey<ScaffoldState> _globalkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    RtriangleController c = Get.find();
    print('build stack');

    var size = MediaQuery.of(context).size;
    var w = size.width;
    var h = size.height;
    print('w $w h $h');
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
                        ? imageFigure = RTriangleImageInputWidget()
                        : imageFigure = RTriangleImageInfoWidget();

                    return Container(
                      child: imageFigure,
                      margin: EdgeInsets.all(kDefaultMargin),
                      decoration: BoxDecoration(
                          color: ColorsApp.content(context),
                          borderRadius: BorderRadius.all(
                              Radius.circular(kDefaultRadius))),
                    );
                  }),
                  Container(
                    margin: EdgeInsets.all(kDefaultMargin),
                    width: 1.sw,
                    height: 0.1.sh,
                    decoration: BoxDecoration(
                        color: ColorsApp.content(context),
                        borderRadius:
                            BorderRadius.all(Radius.circular(kDefaultRadius))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          TranslateHelper.rightTriangle,
                          style: StyleTextInfo.mainText,
                        ),
                        Divider(
                          color: Colors.white,
                        ),
                        Text(
                          TranslateHelper.enterTwoParameters,
                          style: StyleTextInfo.subText,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(kDefaultMargin),
                      decoration: BoxDecoration(
                          color: ColorsApp.content(context),
                          borderRadius: BorderRadius.all(
                              Radius.circular(kDefaultRadius))),
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
              IconButton(
                  onPressed: () {
                    _globalkey.currentState?.openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: kPrimaryColor,
                  )),
            ],
          ),
        ));
  }
}
