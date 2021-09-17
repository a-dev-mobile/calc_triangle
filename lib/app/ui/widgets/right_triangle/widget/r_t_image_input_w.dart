import 'dart:math';

import 'package:calc_triangle/app/constant/const_assets.dart';
import 'package:calc_triangle/app/constant/const_number.dart';
import 'package:calc_triangle/app/ui/theme/app_color.dart';
import 'package:calc_triangle/app/ui/widgets/right_triangle/widget/h_height_w.dart';
import 'package:calc_triangle/app/ui/widgets/right_triangle/widget/m_com_c_side_w.dart';
import 'package:calc_triangle/app/utils/app_utils.dart';
import 'package:flutter/material.dart';

import 'a_angle_w.dart';
import 'a_cathet_w.dart';
import 'b_angle_w.dart';
import 'b_cathet_w.dart';
import 'c_hypotenusea_w.dart';
import 'k_com_c_side_w.dart';

class RtImageInputWidget extends StatelessWidget {
  const RtImageInputWidget({
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
                image: const AssetImage(ConstAssets.rightTriangleInput),
              ),
            ),
            //all widget text in image

            const HheightWidget(angle: -45, posX: -18.225, posY: 18.225),
            const KcompCside(angle: 45, posX: -12.994, posY: -23.456),
            const McompCside(angle: 45, posX: 23.456, posY: 12.994),
            const BangleWidget( posX: -20.573, posY: 0),
            const AangleWidget( posX: -3.0, posY: 23.943),
            const BcathetWidget(angle: -90, posX: -43.845, posY: 0),
            const AcathetWidget(posX: 0, posY: 43.545),
            const ChypotenuseWidget(angle: 45, posX: 11.093, posY: -11.093),
          ],
        );
      }),
    );
  }
}
