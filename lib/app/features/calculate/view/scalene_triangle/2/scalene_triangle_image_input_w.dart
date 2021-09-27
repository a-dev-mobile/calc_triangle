import 'dart:math';

import 'package:calc_triangle/app/config/theme/app_color.dart';
import 'package:calc_triangle/app/constants/const_assets.dart';
import 'package:calc_triangle/app/constants/const_number.dart';
import 'package:calc_triangle/app/features/calculate/view/scalene_triangle/3/h_height_w.dart';

import 'package:flutter/material.dart';

String pathAssestInput = ConstImageRaster.scaleneTriangleInput;

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

            HheightWidget(
              angle: -90,
              posX: -16.503,
              posY: 7.051,
              minSizeImage: minSize,
            ),
            // const HheightWidget(angle: -45, posX: -18.225, posY: 18.225),
            // const KcompCside(angle: 45, posX: -12.994, posY: -23.456),
            // const McompCside(angle: 45, posX: 23.456, posY: 12.994),
            // const BangleWidget( posX: -20.573, posY: 0),
            // const AangleWidget( posX: -3.0, posY: 23.943),
            // const BcathetWidget(angle: -90, posX: -43.845, posY: 0),
            // const AcathetWidget(posX: 0, posY: 43.545),
            // const ChypotenuseWidget(angle: 45, posX: 11.093, posY: -11.093),
          ],
        );
      }),
    );
  }
}
