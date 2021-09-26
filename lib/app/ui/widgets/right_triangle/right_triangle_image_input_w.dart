import 'dart:math';

import 'package:calc_triangle/app/config/theme/app_color.dart';
import 'package:calc_triangle/app/constants/const_assets.dart';
import 'package:calc_triangle/app/constants/const_number.dart';

import 'package:calc_triangle/app/ui/widgets/right_triangle/a_angle_w.dart';
import 'package:calc_triangle/app/ui/widgets/right_triangle/a_cathet_w.dart';
import 'package:calc_triangle/app/ui/widgets/right_triangle/b_angle_w.dart';
import 'package:calc_triangle/app/ui/widgets/right_triangle/b_cathet_w.dart';
import 'package:calc_triangle/app/ui/widgets/right_triangle/c_hypotenusea_w.dart';
import 'package:calc_triangle/app/ui/widgets/right_triangle/h_height_w.dart';
import 'package:calc_triangle/app/ui/widgets/right_triangle/k_com_c_side_w.dart';
import 'package:calc_triangle/app/ui/widgets/right_triangle/m_com_c_side_w.dart';

import 'package:flutter/material.dart';

class RightTriangleImageInputWidget extends StatelessWidget {
  const RightTriangleImageInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * ConstNumber.ratioFigureImage,
      width: size.width,
      child: LayoutBuilder(builder: (context, constraints) {
        var minSize = min(constraints.maxWidth, constraints.maxHeight);

// сохраняем в глоб переменные

        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox.expand(
              child: Image(
                fit: BoxFit.contain,
                color: AppColors.text(context),
                image: const AssetImage(ConstImageRaster.rightTriangleInput),
              ),
            ),
            //all widget text in image

            HheightWidget(
              angle: -45,
              posX: -18.225,
              posY: 18.225,
              minSizeImage: minSize,
            ),
            KcompCside(
              angle: 45,
              posX: -12.994,
              posY: -23.456,
              minSizeImage: minSize,
            ),
            McompCside(
              angle: 45,
              posX: 23.456,
              posY: 12.994,
              minSizeImage: minSize,
            ),
            BangleWidget(
              posX: -20.573,
              posY: 0,
              minSizeImage: minSize,
            ),
            AangleWidget(
              posX: -3.0,
              posY: 23.943,
              minSizeImage: minSize,
            ),
            BcathetWidget(
              angle: -90,
              posX: -43.845,
              posY: 0,
              minSizeImage: minSize,
            ),
            AcathetWidget(
              posX: 0,
              posY: 43.545,
              minSizeImage: minSize,
            ),
            ChypotenuseWidget(
              angle: 45,
              posX: 11.093,
              posY: -11.093,
              minSizeImage: minSize,
            ),
          ],
        );
      }),
    );
  }
}
