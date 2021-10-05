import 'dart:math';

import 'package:calc_triangle/app/config/theme/app_color.dart';
import 'package:calc_triangle/app/constants/const_assets.dart';
import 'package:calc_triangle/app/constants/const_number.dart';
import 'package:calc_triangle/app/features/calculate/view/equilateral/3/a_side_w.dart';
import 'package:calc_triangle/app/features/calculate/view/equilateral/3/h_height_w.dart';


import 'package:flutter/material.dart';

String pathAssestInput = ConstAssetsImageRaster.equilateralTriangleInput;

class EquilateralTriangleImageInputWidget extends StatelessWidget {
  const EquilateralTriangleImageInputWidget({Key? key}) : super(key: key);

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

            HheightWidget(
              angle: -45,
              posX: -18.225,
              posY: 18.225,
              minSizeImage: minSize,
            ),
           
            AsideWidget(
              posX: 0,
              posY: 43.545,
              minSizeImage: minSize, angle: 0,
            ),
         
          ],
        );
      }),
    );
  }
}
