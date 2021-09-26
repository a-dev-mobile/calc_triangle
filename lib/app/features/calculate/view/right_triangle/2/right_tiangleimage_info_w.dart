import 'package:calc_triangle/app/config/theme/app_color.dart';
import 'package:calc_triangle/app/constants/const_assets.dart';
import 'package:calc_triangle/app/constants/const_number.dart';

import 'package:flutter/material.dart';

String pathAssestInfo = ConstImageRaster.rightTriangleInfo;

class RightTriangleImageInfoWidget extends StatelessWidget {
  const RightTriangleImageInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
        height: size.height * ConstNumber.ratioFigureImage,
        width: size.width,
        child: SizedBox.expand(
          child: Image(
            fit: BoxFit.contain,
            color: AppColors.text(context),
            image: AssetImage(pathAssestInfo),
          ),
        ));
  }
}
