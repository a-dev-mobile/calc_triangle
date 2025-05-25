import 'package:calc_triangle/app/config/theme/app_style.dart';
import 'package:calc_triangle/app/shared_components/triangle_visualization_widget.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';
import 'package:calc_triangle/app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AreaAndPerimeterWidget extends StatelessWidget {
  final RxString area;
  final RxString perimeter;
  final RxBool isActiveSnackBar;
  final TriangleVisualizationConfig Function() triangleConfigBuilder;

  const AreaAndPerimeterWidget({
    super.key,
    required this.area,
    required this.perimeter,
    required this.isActiveSnackBar,
    required this.triangleConfigBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
        visible: !isActiveSnackBar.value,
        child: SizedBox(
          width: 1.sw,
          height: AppUtils.getHeight(context) * 0.06,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 20.w,
                top: 0,
                bottom: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      TranslateHelper.area,
                      style: AppStyleText.titleText(context),
                    ),
                    Text(area.value, style: AppStyleText.subText(context)),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
                child: Center(
                  child: Obx(() {
                    final config = triangleConfigBuilder();
                    
                    return TriangleVisualizationWidget(
                      sideA: config.sideA,
                      sideB: config.sideB,
                      sideC: config.sideC,
                      angleA: config.angleA,
                      angleB: config.angleB,
                      angleC: config.angleC,
                      triangleType: config.triangleType,
                      isValid: config.isValid && !isActiveSnackBar.value,
                    );
                  }),
                ),
              ),
              Positioned(
                right: 20.w,
                top: 0,
                bottom: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      TranslateHelper.perimeter,
                      style: AppStyleText.titleText(context),
                    ),
                    Text(
                      perimeter.value,
                      style: AppStyleText.subText(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class TriangleVisualizationConfig {
  final double? sideA;
  final double? sideB;
  final double? sideC;
  final double? angleA;
  final double? angleB;
  final double? angleC;
  final TriangleType triangleType;
  final bool isValid;

  const TriangleVisualizationConfig({
    this.sideA,
    this.sideB,
    this.sideC,
    this.angleA,
    this.angleB,
    this.angleC,
    required this.triangleType,
    required this.isValid,
  });
}