import 'package:calc_triangle/app/routes/app_page.dart';
import 'package:calc_triangle/app/routes/app_routes.dart';
import 'package:calc_triangle/app/ui/pages/right_triangle/right_triangle_p.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/controller/r_triangle/r_triangle_c.dart';
import 'app/translations/app_translations.dart';
import 'app/ui/pages/welcome/welcome_p.dart';
import 'app/ui/theme/light_dark_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // if (Platform.isAndroid) {
  //   await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  // }

  // Get.put(RtriangleController());
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
            initialRoute: Routes.INITIAL,
            // home: RighTrianglePage(),
            // home: ChangeListPage(),
            defaultTransition: Transition.fade,
            getPages: AppPage.pages,
            theme: lightThemeData(context),
            darkTheme: darkThemeData(context),

            translations: AppTranslation(),
            
            locale: Get.locale ?? const Locale('en'),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
