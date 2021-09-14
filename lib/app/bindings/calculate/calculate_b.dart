import 'package:calc_triangle/app/controller/calculate/right_triangle_c.dart';
import 'package:calc_triangle/app/controller/welcome/welcome_c.dart';

import 'package:get/get.dart';

class CalculateBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RightTriangleController());
    Get.lazyPut(() => WelcomeController());

  }
}
