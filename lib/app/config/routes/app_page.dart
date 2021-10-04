import 'package:calc_triangle/app/features/calculate/controllers/right_c.dart';
import 'package:calc_triangle/app/features/calculate/controllers/scalene_c.dart';

import 'package:calc_triangle/app/features/calculate/view/right/calculate_right.dart';
import 'package:calc_triangle/app/features/calculate/view/scalene/calculate_scalene.dart';
import 'package:calc_triangle/app/features/select_shape/select_shape_p.dart';

import 'package:calc_triangle/app/features/setting/controller/setting_c.dart';
import 'package:calc_triangle/app/features/setting/view/setting_p.dart';
import 'package:calc_triangle/app/features/welcome/welcome_p.dart';

import 'package:get/get.dart';

abstract class Routes {
  static const initial = welcome;
  static const welcome = '/welcome';
  static const selectShape = '/selectShape';

  static const calculateRight = '/calculateRight';
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
        name: Routes.calculateRight,
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
