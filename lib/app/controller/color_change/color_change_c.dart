import 'package:calc_triangle/app/constant/string_const.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ColorChangeController extends GetxController {
  var isDarkTheme = false.obs;
  final box = GetStorage();
  void toggle() {
    isDarkTheme.value = isDarkTheme.value ? false : true;

    box.write(StringConst.kKeyIsDarkTheme, isDarkTheme.value);
  }

  @override
  void onInit() {
    print('init ColorChangeController');
    isDarkTheme.value = box.read(StringConst.kKeyIsDarkTheme) ?? false;
    super.onInit();
  }
}
