import 'package:calc_triangle/app/controller/setting/setting_c.dart';
import 'package:calc_triangle/app/controller/welcome/welcome_c.dart';
import 'package:get/get.dart';


class SettingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingController());
    Get.lazyPut(() => WelcomeController());
  }
}
