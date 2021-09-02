
import 'package:calc_triangle/app/controller/select_shape/select_shape_c.dart';
import 'package:get/get.dart';

class SelectShapeBinding implements Bindings {
  @override
  void dependencies() {
    print('binding WelcomeBinding');
    Get.lazyPut(() => SelectShapeController());
  }
}
