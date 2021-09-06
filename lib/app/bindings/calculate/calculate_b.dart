import 'package:calc_triangle/app/controller/calculate/calculate_c.dart';
import 'package:calc_triangle/main.dart';

import 'package:get/get.dart';


class CalculateBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CalculateController());
  }
}
