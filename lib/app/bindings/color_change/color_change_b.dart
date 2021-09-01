import 'package:calc_triangle/app/controller/color_change/color_change_c.dart';
import 'package:get/get.dart';

class ColorChangeBinding implements Bindings {
  @override
  void dependencies() {
    print('binding ColorChangeController');
    Get.lazyPut(() => ColorChangeController());
  }
}
