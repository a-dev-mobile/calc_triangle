import 'package:calc_triangle/app/controller/setting/setting_c.dart';
import 'package:calc_triangle/app/controller/welcome/welcome_c.dart';
import 'package:get/get.dart';

import '../../../main.dart';

class WelcomeBinding implements Bindings {
  @override
  void dependencies() {
    printt.v("WelcomeBinding");
    Get.lazyPut(() => WelcomeController());
    Get.lazyPut(() => SettingController());
  }
}
