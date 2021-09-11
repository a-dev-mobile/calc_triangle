import 'package:calc_triangle/app/bindings/calculate/calculate_b.dart';
import 'package:calc_triangle/app/bindings/setting/setting_b.dart';

import 'package:calc_triangle/app/bindings/welcome/welcom_b.dart';
import 'package:calc_triangle/app/controller/setting/setting_c.dart';
import 'package:calc_triangle/app/ui/pages/calculate/calculate_p.dart';

import 'package:calc_triangle/app/ui/pages/setting/setting_p.dart';

import 'package:calc_triangle/app/ui/pages/welcome/welcome_p.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPage {
  static final pages = [
    GetPage(
        name: Routes.INITIAL,
        page: () => const WelcomePage(),
        transition: Transition.fade,
        binding: WelcomeBinding()),
    GetPage(
        name: Routes.CALCULATE,
        transition: Transition.rightToLeft,
        page: () => const CalculatePage(),
        binding: CalculateBinding()),
    GetPage(
      name: Routes.SETTING,
      transition: Transition.native,
      binding: SettingBinding(),
      page: () => SettingPage(),
    ),
  ];
}
