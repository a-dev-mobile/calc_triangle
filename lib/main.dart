import 'package:calc_triangle/app/constant/string_const.dart';
import 'package:calc_triangle/app/routes/app_page.dart';
import 'package:calc_triangle/app/routes/app_routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/translations/app_translations.dart';

import 'app/ui/theme/light_dark_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return ScreenUtilInit(
        designSize: const Size(1080, 2400),
        builder: () {
          var isDarkTheme = GetStorage().read(StringConst.keyIsDarkTheme)??false;
         
          return GetMaterialApp(
            initialRoute: Routes.INITIAL,
            defaultTransition: Transition.cupertino,
            getPages: AppPage.pages,
            themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
            theme: lightThemeData(context),
            // theme: isDarkTheme ? darkThemeData(context) : lightThemeData(context),
            darkTheme: darkThemeData(context),
            translations: AppTranslation(),
            locale: Get.locale ?? const Locale('en'),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
