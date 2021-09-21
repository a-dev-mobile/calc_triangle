import 'package:calc_triangle/app/controller/calculate/right_triangle_c.dart';
import 'package:calc_triangle/app/controller/calculate/scalene_triangle_c.dart';
import 'package:calc_triangle/app/controller/select_shape/select_shape_c.dart';
import 'package:calc_triangle/app/controller/welcome/welcome_c.dart';

import 'package:get/get.dart';

class SelectShapeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(() => SelectShapeController());
    Get.put(() => ScaleneTriangleController());
    Get.put(() => RightTriangleController());

  }
}
