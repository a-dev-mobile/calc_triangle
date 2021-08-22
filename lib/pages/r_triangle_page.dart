// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:convert';
import 'dart:math';

import 'package:calc_triangle/pages/widget/formulas_web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const.dart';
import 'widget/btn_image.dart';

class RighTriangelePage extends StatelessWidget {
  const RighTriangelePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var w = size.width;
    var h = size.height;
    print('w $w h $h');

    return Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 0.4.sh,
              width: 1.sw,
              child: LayoutBuilder(builder: (context, constraints) {
                var wStack = constraints.maxWidth;
                var hStack = constraints.maxHeight;
                var minSize = min(wStack, hStack);
                print('1wStack $wStack hStack $hStack');
                print('1minSize $minSize');

                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox.expand(
                      child: Image(
                        fit: BoxFit.contain,
                        image: AssetImage('assets/image/triangle/4_6.png'),
                      ),
                    ),
                    BtnImage(
                      minSize: minSize,
                      text: '123.123',
                      angle: -67.66,
                      colorBgBtn: Color.fromRGBO(72, 72, 72, 1),
                      colorTextBtn: Colors.white,
                      fontSize: 40.sp,
                      posX: -5.396,
                      posY: 19.117,
                    ),
                    BtnImage(
                      minSize: minSize,
                      text: '222.222',
                      angle: -22.96,
                      colorBgBtn: Color.fromRGBO(72, 72, 72, 1),
                      colorTextBtn: Colors.white,
                      fontSize: 40.sp,
                      posX: -18.073,
                      posY: 7.915,
                    ),
                    BtnImage(
                      minSize: minSize,
                      text: '233.333',
                      angle: 45,
                      colorBgBtn: Color.fromRGBO(72, 72, 72, 1),
                      colorTextBtn: Colors.white,
                      fontSize: 60.sp,
                      posX: 4.166,
                      posY: -4.166,
                    ),
                    BtnImage(
                      minSize: minSize,
                      text: '4444.4444',
                      angle: 0,
                      colorBgBtn: Color.fromRGBO(72, 72, 72, 1),
                      colorTextBtn: Colors.white,
                      fontSize: 60.sp,
                      posX: 0,
                      posY: 43.345,
                    ),
                    BtnImage(
                      minSize: minSize,
                      text: '111.111',
                      angle: -90,
                      colorBgBtn: Color.fromRGBO(72, 72, 72, 1),
                      colorTextBtn: Colors.white,
                      fontSize: 60.sp,
                      posX: -42.845,
                      posY: 0,
                    ),
                  ],
                );
              }),
            ),
            Container(
              width: 1.sw,
              height: 0.2.sh,
              color: Colors.grey,
            ),
            Container(
              width: 1.sw,
              height: 0.2.sh,
              color: Colors.green,
            ),
            SizedBox(
              width: 1.sw,
              height: 0.2.sh ,
              child: FormulasWebView(),
            ),
          ],
        ));
  }
}
