// ignore_for_file: prefer_const_constructors, unused_field, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:calc_triangle/pages/home_page.dart';
import 'package:calc_triangle/pages/widget/image_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(1080, 2400),
        builder: () {
          return MaterialApp(
            home: ImageWidget(),
            theme: ThemeData(
              brightness: Brightness.light,
              /* light theme settings */
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
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
