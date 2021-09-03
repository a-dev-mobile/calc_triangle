import 'package:calc_triangle/app/constant/const.dart';
import 'package:calc_triangle/app/routes/app_page.dart';
import 'package:calc_triangle/app/routes/app_routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';


import 'app/translations/app_translations.dart';

import 'app/ui/theme/light_dark_theme.dart';


var logger = Logger(
  printer: PrettyPrinter(methodCount:2),
);

var printt = Logger(
  printer: PrettyPrinter(methodCount: 0),
);



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

// // Logger.level = Level.nothing;
//  logger.d('Log message with 2 methods');

//   loggerNoStack.i('Info message');

//   loggerNoStack.w('Just a warning!');

//   logger.e('Error! Something bad happened', 'Test Error');

//   loggerNoStack.v({'key': 5, 'value': 'something'});

//   Logger(printer: SimplePrinter(colors: true)).v('boom');



  await GetStorage.init();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(1080, 2400),
        builder: () {
          var isDarkTheme =
              GetStorage().read(ConstString.keyIsDarkTheme) ?? false;

          return GetMaterialApp(
            initialRoute: Routes.INITIAL,
            defaultTransition: Transition.downToUp,
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
