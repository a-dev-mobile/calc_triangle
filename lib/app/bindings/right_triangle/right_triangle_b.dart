import 'package:calc_triangle/app/controller/right_triangle/right_triangle_c.dart';
import 'package:calc_triangle/main.dart';

import 'package:get/get.dart';


class RightTriangleBinding implements Bindings {
  @override
  void dependencies() {
    printt.v("RightTriangleBinding");

    Get.lazyPut(() => RightTriangleController());
  }
}
