import 'package:calc_triangle/app/config/theme/app_color.dart';
import 'package:calc_triangle/app/config/theme/app_size.dart';
import 'package:calc_triangle/app/config/theme/app_style.dart';
import 'package:calc_triangle/app/config/theme/light_dark_theme.dart';
import 'package:calc_triangle/app/constants/const_color.dart';
import 'package:calc_triangle/app/features/calculate/controllers/right_c.dart';
import 'package:calc_triangle/app/features/calculate/view/right/2/right_numpad_w.dart';
import 'package:calc_triangle/app/shared_components/custom_snakbar_w.dart';
import 'package:calc_triangle/app/shared_components/floating_back_button.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';
import 'package:calc_triangle/app/utils/app_utils.dart';
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
                            child: const AreaAndPerimeterWidget(),
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

class AreaAndPerimeterWidget extends StatelessWidget {
  const AreaAndPerimeterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
        visible: !c.isActiveSnackBar.value,
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
                    Text(c.area.value, style: AppStyleText.subText(context)),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
                child: Icon(
                  Icons.done,
                  color: ConstColor.secondary,
                  size: 50.sp,
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
                      c.perimeter.value,
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
