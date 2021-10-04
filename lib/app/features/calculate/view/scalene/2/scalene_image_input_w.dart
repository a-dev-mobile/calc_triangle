import 'dart:math';

import 'package:calc_triangle/app/config/theme/app_color.dart';
import 'package:calc_triangle/app/constants/const_assets.dart';
import 'package:calc_triangle/app/constants/const_number.dart';
import 'package:calc_triangle/app/features/calculate/view/scalene/3/a_angle_w.dart';
import 'package:calc_triangle/app/features/calculate/view/scalene/3/a_side_w.dart';
import 'package:calc_triangle/app/features/calculate/view/scalene/3/b_angle_w.dart';
import 'package:calc_triangle/app/features/calculate/view/scalene/3/b_side_w.dart';
import 'package:calc_triangle/app/features/calculate/view/scalene/3/c_side_w.dart';
import 'package:calc_triangle/app/features/calculate/view/scalene/3/h_height_w.dart';
import 'package:calc_triangle/app/features/calculate/view/scalene/3/y_angle_w.dart';

import 'package:flutter/material.dart';

String pathAssestInput = ConstAssetsImageRaster.scaleneTriangleInput;

class ScaleneTriangleImageInputWidget extends StatelessWidget {
  const ScaleneTriangleImageInputWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * ConstNumber.ratioFigureImage,
      width: size.width,
      child: LayoutBuilder(builder: (context, constraints) {
        var minSize = min(constraints.maxWidth, constraints.maxHeight);

        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox.expand(
              child: Image(
                fit: BoxFit.contain,
                color: AppColors.text(context),
                image: AssetImage(pathAssestInput),
              ),
            ),
            //all widget text in image

         
            AsideWidget(
              angle: 0,
              posX: -4.711,
              posY: 43.377,
              minSizeImage: minSize,
            ),
            CsideWidget(
              angle: -71.323,
              posX: -35.572,
              posY: -1.783,
              minSizeImage: minSize,
            ),
            BsideWidget(
              angle: 56.523,
              posX: 13.244,
              posY: -3.719,
              minSizeImage: minSize,
            ),
          
               HheightWidget(
              angle: -90,
              posX: -16.503,
              posY: 7.051,
              minSizeImage: minSize,
            ),
              AangleWidget(
              angle: 54.341,
              posX: -22.37,
              posY: 22.748,
              minSizeImage: minSize,
            ),
            BangleWidget(
              angle: -61.705,
              posX: 8.008,
              posY: 23.864,
              minSizeImage: minSize,
            ),
            YangleWidget(
              angle: -7.381,
              posX: -13.56,
              posY: -13.39,
              minSizeImage: minSize,
            )
           
          ],
        );
      }),
    );
  }
}
