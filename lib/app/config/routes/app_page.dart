import 'package:calc_triangle/app/controller/calculate_right/right_triangle_c.dart';
import 'package:calc_triangle/app/controller/calculate_scalene/scalene_triangle_c.dart';

import 'package:calc_triangle/app/controller/setting/setting_c.dart';
import 'package:calc_triangle/app/ui/pages/calculate_right/calculate_admob_right_p.dart';
import 'package:calc_triangle/app/ui/pages/calculate_scalene/calculate_scalene_p.dart';

import 'package:calc_triangle/app/ui/pages/select_shape/select_shape_p.dart';

import 'package:calc_triangle/app/ui/pages/setting/setting_p.dart';
import 'package:calc_triangle/app/ui/pages/welcome/welcome_p.dart';


import 'package:get/get.dart';

abstract class Routes {
  static const initial = welcome;
  static const welcome = '/welcome';
  static const selectShape = '/selectShape';
  static const calculate = '/calculate';
  static const calculateScalene = '/calculateScalene';
  static const setting = '/setting';
}

class AppPage {
  static final pages = [
    GetPage(
        name: Routes.welcome,
        page: () => const WelcomePage(),
        binding: BindingsBuilder(() {
          Get.put<SettingContrl>(SettingContrl());
        })),
    GetPage(
      name: Routes.selectShape,
      page: () => const SelectShapePage(),
    ),
    GetPage(
        name: Routes.calculate,
        page: () => const CalculateRightPage(),
        binding: BindingsBuilder(() {
          Get.put<RightTriangleController>(RightTriangleController());
        })),
    GetPage(
        name: Routes.calculateScalene,
        page: () => const CalculateScalenePage(),
        binding: BindingsBuilder(() {
          Get.put<ScaleneTriangleController>(ScaleneTriangleController());
        })),
    GetPage(
        name: Routes.setting,
        page: () => const SettingPage(),
        binding: BindingsBuilder(() {
          Get.put<SettingContrl>(SettingContrl());
        })),
  ];
}
