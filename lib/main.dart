
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controllers/r_triangle_c.dart';
import 'localization/localization.dart';

import 'theme/light_dark_theme.dart';
import 'ui/pages/right_triangle/right_triangle_p.dart';
import 'ui/pages/welcome/welcome_p.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // if (Platform.isAndroid) {
  //   await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  // }

  Get.put(RtriangleController());
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

          return GetMaterialApp(
            home:  WelcomePage(),
            // home: ChangeListPage(),

            theme: lightThemeData(context),
            darkTheme: darkThemeData(context),

            translations: Localization(),
            locale: Get.locale ?? const Locale('en'),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
