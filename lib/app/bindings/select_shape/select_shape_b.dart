
import 'package:calc_triangle/app/controller/select_shape/select_shape_c.dart';
import 'package:get/get.dart';

import '../../../main.dart';

class SelectShapeBinding implements Bindings {
  @override
  void dependencies() {
    printt.v("SelectShapeBinding");
    Get.lazyPut(() => SelectShapeController());
  }
}
