import 'dart:math';

import 'package:calc_triangle/app/config/theme/app_color.dart';
import 'package:calc_triangle/app/constants/const_assets.dart';
import 'package:calc_triangle/app/constants/const_number.dart';
import 'package:calc_triangle/app/features/calculate/view/right/3/a_angle_w.dart';
import 'package:calc_triangle/app/features/calculate/view/right/3/a_cathet_w.dart';
import 'package:calc_triangle/app/features/calculate/view/right/3/b_angle_w.dart';
import 'package:calc_triangle/app/features/calculate/view/right/3/b_cathet_w.dart';
import 'package:calc_triangle/app/features/calculate/view/right/3/c_hypotenuse_w.dart';
import 'package:calc_triangle/app/features/calculate/view/right/3/h_height_w.dart';
import 'package:calc_triangle/app/features/calculate/view/right/3/k_com_c_side_w.dart';
import 'package:calc_triangle/app/features/calculate/view/right/3/m_com_c_side_w.dart';

import 'package:flutter/material.dart';

String pathAssestInput = ConstAssetsImageRaster.rightTriangleInput;

class RightTriangleImageInputWidget extends StatelessWidget {
  const RightTriangleImageInputWidget({super.key});

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
                angle: 0,
              ),
              AangleWidget(
                posX: -3.0,
                posY: 23.943,
                minSizeImage: minSize,
                angle: 0,
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
                angle: 0,
              ),
              ChypotenuseWidget(
                angle: 45,
                posX: 11.093,
                posY: -11.093,
                minSizeImage: minSize,
              ),
            ],
          );
        },
      ),
    );
  }
}
