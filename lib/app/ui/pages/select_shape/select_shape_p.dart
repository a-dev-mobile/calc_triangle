import 'package:calc_triangle/app/constant/const_assets.dart';
import 'package:calc_triangle/app/controller/select_shape/select_shape_c.dart';
import 'package:calc_triangle/app/routes/app_routes.dart';
import 'package:calc_triangle/app/ui/widgets/other/image_info_w.dart';
import 'package:calc_triangle/app/ui/widgets/scalene_triangle/scalene_triangle_input_w.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

  late SelectShapeController c = Get.find();
class SelectShapePage extends StatelessWidget {
  const SelectShapePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GridView.count(
        crossAxisCount: 1,
        children: [
          InkWell(
              onTap: () {
                c.activeShape = Shape.rightTriangle;
                // SelectShapeController.to.initWidgetControllerPath();
                Get.toNamed(
                  Routes.calculate,
                );
              },
              child: const ImageInfoWidget(
                  pathAsset: ConstAssets.rightTriangleInfo)),
          InkWell(
              onTap: () {
                 c.activeShape = Shape.scaleneTriangle;
                Get.toNamed(Routes.calculate);
              },
              child: const ImageInfoWidget(
                  pathAsset: ConstAssets.scaleneTriangleInfo)),
        ],
      )),
    );
  }
}
