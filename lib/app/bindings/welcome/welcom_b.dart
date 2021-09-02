
import 'package:calc_triangle/app/controller/welcome/welcome_c.dart';
import 'package:get/get.dart';

class WelcomeBinding implements Bindings {
  @override
  void dependencies() {
    print('binding WelcomeBinding');
    Get.lazyPut(() => WelcomeController());
  }
}
