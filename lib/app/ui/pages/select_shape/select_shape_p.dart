
import 'package:calc_triangle/app/controller/select_shape/select_shape_c.dart';
import 'package:calc_triangle/app/ui/pages/right_triangle/widget/r_triangle_image_info_w.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectShapePage extends GetView<SelectShapeController> {
  const SelectShapePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var c = controller;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
      RTriangleImageInfoWidget()
          ],
        ),
      ),
    );
  }
}
