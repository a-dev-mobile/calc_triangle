import 'package:calc_triangle/app/bindings/right_triangle/right_triangle_b.dart';
import 'package:calc_triangle/app/bindings/select_shape/select_shape_b.dart';
import 'package:calc_triangle/app/bindings/welcome/welcom_b.dart';


import 'package:calc_triangle/app/ui/pages/right_triangle/right_triangle_input_p.dart';
import 'package:calc_triangle/app/ui/pages/select_shape/select_shape_p.dart';

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
        name: Routes.SELECT_SHAPE,
        page: () => const SelectShapePage(),
        transition: Transition.rightToLeft,
        binding: SelectShapeBinding()),
    GetPage(
        name: Routes.RIGHT_TRIANGLE_INPUT,
        transition: Transition.rightToLeft,
        page: () => RighTrianglePageInput(),
        binding: RightTriangleBinding()),
  ];
}
