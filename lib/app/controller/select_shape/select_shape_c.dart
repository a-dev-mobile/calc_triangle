import 'package:calc_triangle/app/constant/const_assets.dart';

import 'package:calc_triangle/app/ui/widgets/right_triangle/right_triangle_w.dart';
import 'package:calc_triangle/app/ui/widgets/scalene_triangle/scalene_triangle_input_w.dart';
import 'package:calc_triangle/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Shape {
  rightTriangle,
  scaleneTriangle,
  none,
}

class SelectShapeController extends GetxController {
  SelectShapeController get to => Get.find<SelectShapeController>();
  var activeShape = Shape.none;
  var pathShapeInfo = '';
  var pathShapeInput = '';
  // var activeShape = Shape.none.obs;

  late Widget activeWidgetCalculator;

  void initWidgetControllerPath() {
    switch (activeShape) {
      case Shape.scaleneTriangle:
        activeWidgetCalculator = ScaleneTriangleWidget();
        pathShapeInfo = ConstAssets.scaleneTriangleInfo;
        pathShapeInput = ConstAssets.scaleneTriangleInput;

        break;

      case Shape.rightTriangle:
        activeWidgetCalculator = RightTriangleWidget();
        pathShapeInfo = ConstAssets.rightTriangleInfo;
        pathShapeInput = ConstAssets.rightTriangleInput;

        break;
      default:
    }
  }

  init(Shape shape) {
    activeShape = shape;
    printt.i('init SelectShapeController = ${activeShape}');
    this;
  }
}
