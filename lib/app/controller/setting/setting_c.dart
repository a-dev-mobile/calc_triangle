import 'package:calc_triangle/app/controller/welcome/welcome_c.dart';
import 'package:calc_triangle/app/utils/app_utils.dart';
import 'package:get/get.dart';

import '../../../main.dart';

class SettingController extends GetxController {
  var isShowLaunchScreen = AppUtils.isShowLaunchScreen().obs;
  RxBool isRus = false.obs;

  void changeShowLaunchScreen() {
    isShowLaunchScreen.value = !(isShowLaunchScreen.value);

    AppUtils.setShowLaunchScreen(isShowLaunchScreen.value);
  }

  void setRusLocation() {
    isRus.value = true;
  }

  void setEnLocation() {
    isRus.value = false;
  }

  @override
  void onInit() {
    if (AppUtils.getLocale() == 'ru_RU') {
      isRus.value = true;
    } else {
      isRus.value = false;
    }

    super.onInit();
  }
}
