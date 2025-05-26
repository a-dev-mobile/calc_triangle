import 'package:calc_triangle/app/config/theme/app_color.dart';
import 'package:calc_triangle/app/config/theme/app_size.dart';
import 'package:calc_triangle/app/config/theme/light_dark_theme.dart';
import 'package:calc_triangle/app/features/calculate/controllers/right_c.dart';
import 'package:calc_triangle/app/features/calculate/view/right/2/right_numpad_w.dart';
import 'package:calc_triangle/app/shared_components/area_and_perimeter_widget.dart';
import 'package:calc_triangle/app/shared_components/custom_snakbar_w.dart';
import 'package:calc_triangle/app/shared_components/floating_back_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'right_detail_w.dart';
import 'right_image_input_w.dart';

RightTriangleController c = RightTriangleController.to;

class RightMain extends StatelessWidget {
  const RightMain({super.key});

  @override
  Widget build(BuildContext context) {
    settingBar();

    return WillPopScope(
      onWillPop: () async {
        // If we're in the detail view, toggle back to input view instead of navigating back
        if (c.isActiveImageInfo.value) {
          c.isActiveImageInfo.value = false;
          return false; // Prevent navigation
        }
        // Otherwise, allow regular back navigation
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Obx(() {
                return c.isActiveImageInfo.value
                    ? const RightDetail()
                    : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InteractiveViewer(
                          child: const RightTriangleImageInputWidget(),
                        ),

                        //показываем если не инфо
                        Obx(() {
                          return Visibility(
                            visible: !c.isActiveImageInfo.value,
                            child: AreaAndPerimeterWidget(
                              area: c.area,
                              perimeter: c.perimeter,
                              isActiveSnackBar: c.isActiveSnackBar,
                              triangleConfigBuilder:
                                  () => TriangleVisualizationConfig(
                                    sideA:
                                        c.cSideD > 0
                                            ? c.cSideD
                                            : null, // гипотенуза
                                    sideB:
                                        c.aSideD > 0
                                            ? c.aSideD
                                            : null, // катет A
                                    sideC:
                                        c.bSideD > 0
                                            ? c.bSideD
                                            : null, // катет B
                                    angleA: 90.0, // прямой угол
                                    angleB: c.aAngleD > 0 ? c.aAngleD : null,
                                    angleC: c.bAngleD > 0 ? c.bAngleD : null,
                                    triangleType: TriangleType.right,
                                    isValid:
                                        (c.aSideD > 0 ||
                                            c.bSideD > 0 ||
                                            c.cSideD > 0),
                                  ),
                            ),
                          );
                        }),
                        Obx(() {
                          return Visibility(
                            visible: !c.isActiveImageInfo.value,
                            child: const MessageWidget(),
                          );
                        }),

                        const Expanded(child: NumPadRightWidget()),
                      ],
                    );
              }),
              //иконка вверху справа
              Obx(() {
                return c.isActiveImageInfo.value
                    ? const IconInputInfoWidget(
                      icon: Icons.description_outlined,
                    )
                    : const IconInputInfoWidget(icon: Icons.calculate_outlined);
              }),
              // Add floating back button with custom back action
              FloatingBackButton(
                customBackAction: () {
                  if (c.isActiveImageInfo.value) {
                    c.isActiveImageInfo.value = false;
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IconInputInfoWidget extends StatelessWidget {
  const IconInputInfoWidget({required this.icon, super.key});
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10.h,
      right: 20.w,
      child: InkResponse(
        onTap: () {
          c.isActiveImageInfo.value = !(c.isActiveImageInfo.value);
        },
        child: Container(
          color: AppColors.content(context),
          child: Icon(
            icon,
            size: AppSize.iconSize * 1.2,
            color: AppColors.text(context),
          ),
        ),
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  const MessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // показ если что то не то))
      return Visibility(
        visible: c.isActiveSnackBar.value,
        child: CustomMessageView(message: c.messageSnackBar.value),
      );
    });
  }
}
