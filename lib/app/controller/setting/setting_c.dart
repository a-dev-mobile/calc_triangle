import 'package:calc_triangle/app/controller/welcome/welcome_c.dart';
import 'package:calc_triangle/app/utils/app_utils.dart';
import 'package:get/get.dart';

import '../../../main.dart';

class SettingController extends GetxController {
  var isShowLaunchScreen = AppUtils.isShowLaunchScreen().obs;

  void changeShowLaunchScreen() {
    isShowLaunchScreen.value = !(isShowLaunchScreen.value);

    AppUtils.setShowLaunchScreen(isShowLaunchScreen.value);

    
  }
}
