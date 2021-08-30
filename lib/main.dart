// ignore_for_file: prefer_const_constructors, unused_field, avoid_print

import 'dart:io';

import 'package:calc_triangle/constants.dart';
import 'package:calc_triangle/controllers/r_triangle_c.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'pages/right_triangle/right_triangle_p.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  Get.put(RtriangleController());
  await GetStorage.init();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(1080, 2400),
        builder: () {
          return GetMaterialApp(
            home: RighTrianglePage(),
            // home: ChangeListPage(),
            theme: ThemeData.dark(),

            debugShowCheckedModeBanner: false,
          );
        });
  }
}
