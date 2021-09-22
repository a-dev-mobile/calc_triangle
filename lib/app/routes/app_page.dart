import 'package:calc_triangle/app/controller/calculate/right_triangle_c.dart';
import 'package:calc_triangle/app/controller/calculate/scalene_triangle_c.dart';

import 'package:calc_triangle/app/controller/setting/setting_c.dart';
import 'package:calc_triangle/app/ui/pages/calculate/calculate_p.dart';
import 'package:calc_triangle/app/ui/pages/select_shape/select_shape_p.dart';

import 'package:calc_triangle/app/ui/pages/setting/setting_p.dart';

import 'package:calc_triangle/app/ui/pages/welcome/welcome_p.dart';
import 'package:get/get.dart';

// ignore_for_file: constant_identifier_names

abstract class Routes {
  static const initial = welcome;
  static const welcome = '/welcome';
  static const selectShape = '/selectShape';
  static const calculate = '/calculate';
  static const setting = '/setting';
}

class AppPage {
  static final pages = [
    GetPage(
        name: Routes.welcome,
        page: () => const WelcomePage(),
        binding: BindingsBuilder(() {
          Get.put<ContrSetting>(ContrSetting());
        })),
    GetPage(
        name: Routes.selectShape,
        page: () => const SelectShapePage(),),
       
    GetPage(
        name: Routes.calculate,
        page: () => const CalculatePage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<RightTriangleController>(() => RightTriangleController());
          Get.lazyPut<ScaleneTriangleController>(
              () => ScaleneTriangleController());
        })),
    GetPage(
        name: Routes.setting,
        page: () => const SettingPage(),
        binding: BindingsBuilder(() {
          Get.put<ContrSetting>(ContrSetting());
        })),
  ];
}
