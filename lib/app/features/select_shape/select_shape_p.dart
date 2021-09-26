import 'package:calc_triangle/app/config/routes/app_page.dart';
import 'package:calc_triangle/app/constants/const_assets.dart';
import 'package:calc_triangle/app/features/calculate/view/right_triangle/2/right_tiangleimage_info_w.dart';
import 'package:calc_triangle/app/features/calculate/view/scalene_triangle/2/scalene_tiangleimage_info_w.dart';
import 'package:calc_triangle/app/model/calculate_m.dart';
import 'package:calc_triangle/app/shared_components/drawer/drawer_icon_w.dart';
import 'package:calc_triangle/app/shared_components/drawer/drawer_w.dart';

import 'package:calc_triangle/app/utils/app_type.dart';
import 'package:calc_triangle/app/utils/logger.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              crossAxisCount: 1,
              children: [
                InkWell(
                    onTap: () {
                      // SelectShapeController.to.initWidgetControllerPath();
                      logger.i(
                          'Get.offAllNamed(Routes.calculate, arguments: Shape.rightTriangle);');
                      Get.offAllNamed(Routes.calculate,
                          arguments: CalculateModel(
                              pathImageInfo: ConstImageRaster.rightTriangleInfo,
                              pathImageInput:
                                  ConstImageRaster.rightTriangleInput,
                              shape: Shape.rightTriangle));
                    },
                    child: const RightTriangleImageInfoWidget()),
                InkWell(
                    onTap: () {
                      logger.i(
                          'Get.offAllNamed(Routes.calculate, arguments: Shape.scaleneTriangle);');
                      Get.offAllNamed(Routes.calculate,
                          arguments: CalculateModel(
                              pathImageInfo:
                                  ConstImageRaster.scaleneTriangleInfo,
                              pathImageInput:
                                  ConstImageRaster.scaleneTriangleInput,
                              shape: Shape.scaleneTriangle));
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
