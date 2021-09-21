import 'package:calc_triangle/app/constant/const_assets.dart';
import 'package:calc_triangle/app/controller/calculate/right_triangle_c.dart';
import 'package:calc_triangle/app/controller/calculate/scalene_triangle_c.dart';
import 'package:calc_triangle/app/controller/welcome/welcome_c.dart';
import 'package:calc_triangle/app/ui/pages/welcome/welcome_p.dart';

import 'package:calc_triangle/app/ui/widgets/right_triangle/right_triangle_w.dart';
import 'package:calc_triangle/app/ui/widgets/scalene_triangle/scalene_triangle_input_w.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Shape {
  rightTriangle,
  scaleneTriangle,
  none,
}

class SelectShapeController extends GetxController {
  var activeShape = Shape.none;
  var pathShapeInfo = '';
  var pathShapeInput = '';
  // var activeShape = Shape.none.obs;

  late Widget activeWidgetCalculator;
  late var activeController;

  void initWidgetControllerPath(Shape shape) {
    switch (shape) {
      case Shape.scaleneTriangle:
        activeWidgetCalculator = ScaleneTriangleWidget();
        activeController = ScaleneTriangleController();

        pathShapeInfo = ConstAssets.scaleneTriangleInfo;
        pathShapeInput = ConstAssets.scaleneTriangleInput;

        break;
     
      case Shape.rightTriangle:
        activeWidgetCalculator = RightTriangleWidget();
        activeController = RightTriangleController();

        pathShapeInfo = ConstAssets.rightTriangleInfo;
        pathShapeInput = ConstAssets.rightTriangleInput;

        break;
      default:
        activeWidgetCalculator = WelcomePage();
        activeController = WelcomeController();
    }
  }
}
