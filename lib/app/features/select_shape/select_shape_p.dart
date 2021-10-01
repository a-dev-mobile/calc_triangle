import 'package:calc_triangle/app/config/routes/app_page.dart';

import 'package:calc_triangle/app/features/calculate/view/right_triangle/2/right_image_info_w.dart';
import 'package:calc_triangle/app/features/calculate/view/scalene_triangle/2/scalene_image_info_w.dart';
import 'package:calc_triangle/app/services/global_serv.dart';

import 'package:calc_triangle/app/shared_components/drawer/drawer_icon_w.dart';
import 'package:calc_triangle/app/shared_components/drawer/drawer_w.dart';

import 'package:calc_triangle/app/utils/logger.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Shape {
  rightTriangle,
  scaleneTriangle,
  none,
}

class SelectShapePage extends StatelessWidget {
  const SelectShapePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      drawer: const DrawerWidget(),
      key: _globalKey,
      body: SafeArea(
        child: Stack(
          children: [
            GridView.count(
              crossAxisCount: 2,
              children: [
                InkWell(
                    onTap: () {
                      // SelectShapeController.to.initWidgetControllerPath();
                      logger.i(
                          'Get.offAllNamed(Routes.calculate, arguments: Shape.rightTriangle);');
                         GlobalServ.to.aciveShape = Shape.rightTriangle;
                      Get.offAllNamed(Routes.calculate);
                    },
                    child: const RightTriangleImageInfoWidget()),
                InkWell(
                    onTap: () {
                      logger.i(
                          'Get.offAllNamed(Routes.calculate, arguments: Shape.scaleneTriangle);');
                      GlobalServ.to.aciveShape = Shape.scaleneTriangle;
                      Get.offAllNamed(Routes.calculate);
                    },
                    child: const ScaleneTriangleImageInfoWidget()),
              ],
            ),
            DrawerIconWidget(globalkey: _globalKey),
          ],
        ),
      ),
    );
  }
}
