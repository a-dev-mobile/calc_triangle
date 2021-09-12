import 'package:calc_triangle/app/constant/const_color.dart';
import 'package:calc_triangle/app/controller/calculate/right_triangle_c.dart';
import 'package:calc_triangle/app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  var isDarkTheme = false.obs;

  // saveFirstStartToBox() => _box.write(ConstString.keyIsFirstStart, true);
  RxInt precisionResult = 3.obs;

  void setPrecisionResult(int precision) {
    if (precisionResult.value == precision) return;
    precisionResult.value = precision;

    AppUtils.setPrecisionResult(precision);

    RightTriangleController c = Get.find();

    //вызов из другого контроллера для обновления точности результата расчета
    c.numberDigitsAfterPoint = precision;
    c.calculate();
  }

  void setDarkTheme() {

    

    if (isDarkTheme.value == true) return;

    Get.changeThemeMode(ThemeMode.dark);
    isDarkTheme.value = true;

    AppUtils.setIsDarkTheme(isDarkTheme.value);
SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        // systemNavigationBarColor: Colors.black, // navigation bar color
        //  statusBarColor: ConstColor.scaffoldDarkTheme.withOpacity(0.5), // status bar color
        statusBarIconBrightness: Brightness.light, // status bar icons' color
        // systemNavigationBarIconBrightness: Brightness.light, //navigation bar icons' color
    )); 

  Get.changeThemeMode(ThemeMode.dark);

  }

  void setLightTheme() {

    



    if (isDarkTheme.value == false) return;

    Get.changeThemeMode(ThemeMode.light);
    isDarkTheme.value = false;

    AppUtils.setIsDarkTheme(isDarkTheme.value);


SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
        // systemNavigationBarColor: Colors.white, // navigation bar color
        //  statusBarColor: ConstColor.scaffoldLightTheme.withOpacity(0.5), // status bar color
        statusBarIconBrightness: Brightness.light, // status bar icons' color
        // systemNavigationBarIconBrightness: Brightness.dark, //navigation bar icons' color
    )); 



  }

  @override
  void onInit() {
    //инициализация перед запуском и правильное отображение
// setLightTheme(); 
    isDarkTheme.value = AppUtils.isDark();
// setDarkTheme(); 
    precisionResult.value = AppUtils.getPrecisionResults().toInt();
    AppUtils.setFirstStartApp(false);
    
    super.onInit();
  }
}
