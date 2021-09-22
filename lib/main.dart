import 'dart:io';

import 'package:calc_triangle/app/controller/setting/setting_c.dart';
import 'package:calc_triangle/app/routes/app_page.dart';
import 'package:calc_triangle/app/services/serv_glob.dart';

import 'package:calc_triangle/app/utils/app_utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';

import 'app/constant/const_string.dart';
import 'app/translations/app_translations.dart';

import 'app/ui/theme/light_dark_theme.dart';

var log = Logger(
  printer: PrettyPrinter(methodCount: 2),
);

var printt = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await GetStorage.init();

  Get.putAsync<ServGlob>(() async => ServGlob(), permanent: true);

  // Logger.level = Level.nothing; //TODO on LOG

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static GlobalKey<NavigatorState> materialKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 800),
        builder: () {
          return GetMaterialApp(
            navigatorKey: MyApp.materialKey,

            //если первый запуск то запускаем в дальнейшем взависимости от настроек
            initialRoute: ServGlob.to.isFirstStartApp
                ? Routes.welcome
                : ServGlob.to.isShowLaunchScreen.value
                    ? Routes.welcome
                    : Routes.selectShape,

            defaultTransition: Transition.downToUp,
            getPages: AppPage.pages,
            themeMode:
                ServGlob.to.isDark.value ? ThemeMode.dark : ThemeMode.light,
            theme: lightThemeData(context),
            darkTheme: darkThemeData(context),
            translations: AppTranslation(),
            locale: ServGlob.to.appLocale() == ConstString.localeRu
                ? const Locale(ConstString.localeRu)
                : const Locale(ConstString.localeEn),

            debugShowCheckedModeBanner: false,
          );
        });
  }
}
