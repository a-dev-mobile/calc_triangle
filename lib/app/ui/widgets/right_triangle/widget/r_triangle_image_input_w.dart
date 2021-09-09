import 'dart:math';

import 'package:calc_triangle/app/constant/const_assets.dart';
import 'package:calc_triangle/app/constant/const_number.dart';
import 'package:calc_triangle/app/ui/theme/app_color.dart';
import 'package:calc_triangle/app/utils/app_utils.dart';
import 'package:flutter/material.dart';

import 'a_angle_w.dart';
import 'a_cathet_w.dart';
import 'b_angle.dart';
import 'b_cathet_w.dart';
import 'c_hypotenusea_w.dart';

class RightTriangleImageInputWidget extends StatelessWidget {
  const RightTriangleImageInputWidget({
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

        AppUtils.setImageMinSize(minSize);

        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox.expand(
              child: Image(
                fit: BoxFit.contain,
                color: AppColors.text(context),
                image: const AssetImage(ConstAssets.righTriangleInput),
              ),
            ),
            //all widget text in image

            const AcathetWidget(angle: 0, posX: 0, posY: 42.345),
            const BcathetWidget(angle: -90, posX: -42.845, posY: 0),
            const AangleWidget(angle: -67.66, posX: -5.396, posY: 19.117),
            const BangleWidget(angle: -22.96, posX: -18.073, posY: 7.915),
            const ChypotenuseWidget(angle: 45, posX: 4.166, posY: -4.166),
          ],
        );
      }),
    );
  }
}
