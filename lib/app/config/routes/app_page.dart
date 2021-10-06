import 'package:calc_triangle/app/features/calculate/controllers/equilateral_c.dart';
import 'package:calc_triangle/app/features/calculate/controllers/isosceles_c.dart';
import 'package:calc_triangle/app/features/calculate/controllers/right_c.dart';
import 'package:calc_triangle/app/features/calculate/controllers/scalene_c.dart';
import 'package:calc_triangle/app/features/calculate/view/Isosceles/calculate_isosceles.dart';
import 'package:calc_triangle/app/features/calculate/view/equilateral/calculate_equilateral.dart';

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
  static const calculateEquilateral = '/calculateEquilateral';
  static const calculateIsosceles = '/calculateIsosceles';
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
        transition: Transition.leftToRight,
        page: () => const CalculateRightPage(),
        binding: BindingsBuilder(() {
          Get.put<RightTriangleController>(RightTriangleController(),
              permanent: true);
        })),
    GetPage(
        name: Routes.calculateScalene,
        transition: Transition.leftToRight,
        page: () => const CalculateScalenePage(),
        binding: BindingsBuilder(() {
          Get.put<ScaleneTriangleController>(ScaleneTriangleController(),
              permanent: true);
        })),
    GetPage(
        name: Routes.calculateEquilateral,
        transition: Transition.leftToRight,
        page: () => const CalculateEquilateralPage(),
        binding: BindingsBuilder(() {
          Get.put<EquilateralTriangleController>(
              EquilateralTriangleController(),
              permanent: true);
        })),
        GetPage(
        name: Routes.calculateIsosceles,
        transition: Transition.leftToRight,
        page: () => const CalculateIsoscelesPage(),
        binding: BindingsBuilder(() {
          Get.put<IsoscelesTriangleController>(
              IsoscelesTriangleController(),
              permanent: true);
        })),
    GetPage(
        name: Routes.setting,
        page: () => SettingPage(),
        transition: Transition.leftToRight,
        binding: BindingsBuilder(() {
          Get.put<SettingContrl>(SettingContrl());
        })),
  ];
}
