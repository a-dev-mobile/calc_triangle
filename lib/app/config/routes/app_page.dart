import 'package:calc_triangle/app/features/calculate/1/calculate_ad_p.dart';
import 'package:calc_triangle/app/features/calculate/controllers/right_triangle_c.dart';
import 'package:calc_triangle/app/features/calculate/controllers/scalene_triangle_c.dart';
import 'package:calc_triangle/app/features/select_shape/select_shape_p.dart';

import 'package:calc_triangle/app/features/setting/controller/setting_c.dart';
import 'package:calc_triangle/app/features/setting/view/setting_p.dart';
import 'package:calc_triangle/app/features/welcome/views/welcome_p.dart';



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
        page: () => CalculatePage(),
        binding: BindingsBuilder(() {

   Get.lazyPut<RightTriangleController>(() => RightTriangleController());
   Get.lazyPut<ScaleneTriangleController>(() => ScaleneTriangleController());


        })),
  
    GetPage(
        name: Routes.setting,
        page: () => const SettingPage(),
        binding: BindingsBuilder(() {
          Get.put<SettingContrl>(SettingContrl());
        })),
  ];
}
