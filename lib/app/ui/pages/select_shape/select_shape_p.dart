import 'package:calc_triangle/app/controller/select_shape/select_shape_c.dart';
import 'package:calc_triangle/app/routes/app_routes.dart';
import 'package:calc_triangle/app/ui/pages/right_triangle/widget/r_triangle_image_info_w.dart';
import 'package:calc_triangle/app/ui/theme/app_color_style.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectShapePage extends GetView<SelectShapeController> {
  const SelectShapePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var c = controller;

    return Scaffold(
      body: SafeArea(
          child: GridView.count(
        crossAxisCount: 2,
        children: [
          Card(
            color: ColorsApp.content(context),
            elevation: 5,
            shadowColor: ColorsApp.contentReverse(context),
            child: GestureDetector(
              onTap: () {
                print('111object');
                Get.toNamed(Routes.RIGHT_TRIANGLE);
              },
              child: RTriangleImageInfoWidget(),
            ),
          ),
          Card(
            color: ColorsApp.content(context),
            elevation: 5,
            shadowColor: ColorsApp.contentReverse(context),
            child: GestureDetector(
              onTap: () {
                print('object');
              },
              child: RTriangleImageInfoWidget(),
            ),
          ),
          Card(
            color: ColorsApp.content(context),
            elevation: 5,
            shadowColor: ColorsApp.contentReverse(context),
            child: GestureDetector(
              onTap: () {
                print('object');
              },
              child: RTriangleImageInfoWidget(),
            ),
          ),
          Card(
            color: ColorsApp.content(context),
            elevation: 5,
            shadowColor: ColorsApp.contentReverse(context),
            child: GestureDetector(
              onTap: () {
                print('object');
              },
              child: RTriangleImageInfoWidget(),
            ),
          ),
          Card(
            color: ColorsApp.content(context),
            elevation: 5,
            shadowColor: ColorsApp.contentReverse(context),
            child: GestureDetector(
              onTap: () {
                print('object');
              },
              child: RTriangleImageInfoWidget(),
            ),
          ),
          Card(
            color: ColorsApp.content(context),
            elevation: 5,
            shadowColor: ColorsApp.contentReverse(context),
            child: GestureDetector(
              onTap: () {
                print('object');
              },
              child: RTriangleImageInfoWidget(),
            ),
          ),
        ],
      )),
    );
  }
}
