import 'package:calc_triangle/app/config/theme/app_color.dart';
import 'package:calc_triangle/app/constants/const_number.dart';

import 'package:flutter/material.dart';

class ImageInfoWidget extends StatelessWidget {
  const ImageInfoWidget({required this.patchAsset, super.key});
  final String patchAsset;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * ConstNumber.ratioFigureImage,
      width: size.width,
      child: SizedBox.expand(
        child: Image(
          fit: BoxFit.contain,
          color: AppColors.text(context),
          image: AssetImage(patchAsset),
        ),
      ),
    );
  }
}
