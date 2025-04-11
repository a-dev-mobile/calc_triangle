import 'dart:math';

import 'package:calc_triangle/app/config/theme/app_color.dart';
import 'package:calc_triangle/app/constants/const_assets.dart';
import 'package:calc_triangle/app/constants/const_number.dart';
import 'package:calc_triangle/app/features/calculate/view/Isosceles/3/a_angle_w.dart';
import 'package:calc_triangle/app/features/calculate/view/Isosceles/3/a_side_w.dart';
import 'package:calc_triangle/app/features/calculate/view/Isosceles/3/b_angle_w.dart';
import 'package:calc_triangle/app/features/calculate/view/Isosceles/3/b_side_w.dart';
import 'package:calc_triangle/app/features/calculate/view/Isosceles/3/h_height_w.dart';

import 'package:flutter/material.dart';

String pathAssestInput = ConstAssetsImageRaster.isoscelesTriangleInput;

class IsoscelesTriangleImageInputWidget extends StatelessWidget {
  const IsoscelesTriangleImageInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * ConstNumber.ratioFigureImage,
      width: size.width,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double minSize = min(constraints.maxWidth, constraints.maxHeight);

          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              SizedBox.expand(
                child: Image(
                  fit: BoxFit.contain,
                  color: AppColors.text(context),
                  image: AssetImage(pathAssestInput),
                ),
              ),

              //all widget text in image
              HheightWidget(
                angle: -90,
                posX: -2.5,
                posY: 14,
                minSizeImage: minSize,
              ),

              AsideWidget(
                posX: -3,
                posY: 43.545,
                minSizeImage: minSize,
                angle: 0,
              ),
              BsideWidget(
                posX: 25.319,
                posY: -7.219,
                minSizeImage: minSize,
                angle: 61.675,
              ),
              AangleWidget(
                posX: 13,
                posY: 22.5,
                minSizeImage: minSize,
                angle: -61.675,
              ),

              BangleWidget(
                posX: -0.801,
                posY: -9.964,
                minSizeImage: minSize,
                angle: 0,
              ),
            ],
          );
        },
      ),
    );
  }
}
