// ignore_for_file: prefer_const_constructors, unused_field, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:calc_triangle/pages/home_page.dart';
import 'package:calc_triangle/pages/r_triangle_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

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
          return MaterialApp(
            home: RighTriangelePage(),
            theme: ThemeData(
              brightness: Brightness.light,
            
              /* light theme settings */
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
  scaffoldBackgroundColor: Color.fromRGBO(72, 72, 72, 1)
              /* dark theme settings */
            ),
            themeMode: ThemeMode.dark,
            /* ThemeMode.system to follow system theme, 
         ThemeMode.light for light theme, 
         ThemeMode.dark for dark theme
      */
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
