import 'package:calc_triangle/app/controller/right_triangle/right_triangle_c.dart';
import 'package:calc_triangle/app/controller/select_shape/select_shape_c.dart';
import 'package:get/get.dart';

class RightTriangleBinding implements Bindings {
  @override
  void dependencies() {
    print('binding RightTriangleBinding');
    Get.lazyPut(() => RightTriangleController());
  }
}
