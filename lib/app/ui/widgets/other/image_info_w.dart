import 'package:calc_triangle/app/constant/const_assets.dart';
import 'package:calc_triangle/app/constant/const_number.dart';
import 'package:calc_triangle/app/ui/theme/app_color.dart';

import 'package:flutter/material.dart';

class ImageInfoWidget extends StatelessWidget {
  const ImageInfoWidget({
    Key? key, required this.pathAsset,
  }) : super(key: key);
  final String pathAsset;
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
            image: AssetImage(pathAsset),
          ),
        ));
  }
}
