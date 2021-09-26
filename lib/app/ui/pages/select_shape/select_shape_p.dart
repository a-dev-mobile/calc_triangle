import 'package:calc_triangle/app/config/routes/app_page.dart';
import 'package:calc_triangle/app/constants/const_assets.dart';
import 'package:calc_triangle/app/shared_components/drawer/drawer_icon_w.dart';
import 'package:calc_triangle/app/shared_components/drawer/drawer_w.dart';





import 'package:calc_triangle/app/ui/widgets/other/image_info_w.dart';
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
              crossAxisCount: 1,
              children: [
                InkWell(
                    onTap: () {
                      // SelectShapeController.to.initWidgetControllerPath();
                      logger.i(
                          'Get.offAllNamed(Routes.calculate, arguments: Shape.rightTriangle);');
                      Get.toNamed(Routes.calculate);
                    },
                    child: const ImageInfoWidget(
                        pathAsset: ConstImageRaster.rightTriangleInfo)),
                InkWell(
                    onTap: () {
                      logger.i(
                          'Get.offAllNamed(Routes.calculate, arguments: Shape.scaleneTriangle);');
                      Get.toNamed(Routes.calculateScalene);
                    },
                    child: const ImageInfoWidget(
                        pathAsset: ConstImageRaster.scaleneTriangleInfo)),
              ],
            ),
            DrawerIconWidget(globalkey: _globalKey),
          ],
        ),
      ),
    );
  }
}
