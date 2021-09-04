import 'dart:math';

import 'package:calc_triangle/app/constant/const.dart';
import 'package:calc_triangle/app/ui/theme/app_color.dart';
import 'package:calc_triangle/app/ui/theme/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RightTriangleImageInfoWidget extends StatelessWidget {
  const RightTriangleImageInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * ConstDefaultDouble.ratioFigureImage,
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
                image: const AssetImage(ConstAssets.righTriangleInfo),
              ),
            ),
            //all widget text in image

            const TextInfo(angle: 0, posX: 0, posY: 42.345, text: 'a'),
            const TextInfo(angle: 0, posX: -42.845, posY: 0, text: 'b'),
            const TextInfo(angle: 0, posX: -42.845, posY: 0, text: 'b'),
            const TextInfo(angle: 0, posX: -18.225, posY: 18.225, text: 'h'),
            const TextInfo(angle: 0, posX: 10.98, posY: 25.9, text: 'α'),
            const TextInfo(angle: 0, posX: -24.329, posY: -7.188, text: 'β'),
            const TextInfo(angle: 0, posX: 8.4, posY: -8.4, text: 'c'),
            const TextInfo(angle: 0, posX: 22.42, posY: 14.03, text: 'm'),
            const TextInfo(angle: 0, posX: -14.03, posY: -22.42, text: 'k'),
          ],
        );
      }),
    );
  }
}

class TextInfo extends StatelessWidget {
  const TextInfo({
    Key? key,
    required this.posX,
    required this.posY,
    required this.angle,
    required this.text,
  }) : super(key: key);

  final double posX;
  final double posY;
  final double angle;
  final String text;

  @override
  Widget build(BuildContext context) {
    double minSize = AppUtils.getImageMinSize();

    return Transform.translate(
      offset: Offset((posX / 100) * minSize, (posY / 100) * minSize),
      child: Transform.rotate(
          angle: angle * pi / 180,
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.text(context),
              backgroundColor: AppColors.content(context),
              fontSize: 60.sp,
            ),
          )),
    );
  }
}
