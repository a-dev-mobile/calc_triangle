import 'package:calc_triangle/app/bindings/color_change/color_change_b.dart';
import 'package:calc_triangle/app/ui/pages/color_change/color_change_p.dart';
import 'package:calc_triangle/app/ui/pages/welcome/welcome_p.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPage {
  static final pages = [
    GetPage(name: Routes.INITIAL, page: () => const WelcomePage()),
    GetPage(
        name: Routes.CHANGE_COLOR,
        page: () => const ColorChangePage(),
        binding: ColorChangeBinding()),
  ];
}
