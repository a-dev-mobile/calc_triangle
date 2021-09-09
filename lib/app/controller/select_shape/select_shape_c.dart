import 'package:calc_triangle/app/routes/app_routes.dart';
import 'package:calc_triangle/app/utils/app_utils.dart';
import 'package:calc_triangle/main.dart';
import 'package:get/get.dart';

enum Shapes {
  rightTriangle,
  scaleneTriangle,
}

class SelectShapeController extends GetxController {
  RxInt activeShape = 0.obs;

  void click(Shapes shape) {
    Get.toNamed(Routes.CALCULATE);
    AppUtils.setAciveShape(shape.index);
  }
}
