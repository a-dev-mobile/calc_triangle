import 'package:calc_triangle/app/config/theme/app_color.dart';
import 'package:calc_triangle/app/config/theme/app_size.dart';
import 'package:calc_triangle/app/config/theme/app_style.dart';
import 'package:calc_triangle/app/config/theme/light_dark_theme.dart';

import 'package:calc_triangle/app/constants/const_color.dart';
import 'package:calc_triangle/app/features/calculate/controllers/right_triangle_c.dart';

import 'package:calc_triangle/app/features/calculate/view/right_triangle/2/right_image_info_w.dart';
import 'package:calc_triangle/app/features/calculate/view/right_triangle/2/right_image_input_w.dart';
import 'package:calc_triangle/app/features/calculate/view/right_triangle/2/numpad_right_w.dart';

import 'package:calc_triangle/app/shared_components/drawer/drawer_icon_w.dart';
import 'package:calc_triangle/app/shared_components/drawer/drawer_w.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';

import 'package:calc_triangle/app/shared_components/custom_snakbar_w.dart';

import 'package:calc_triangle/app/utils/app_utils.dart';
import 'package:calc_triangle/app/utils/logger.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'detail_info_righ_w.dart';

late var c = RightTriangleController.to;

class RightTriangleMainWidget extends StatelessWidget {
  const RightTriangleMainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

    settingBar();
    return Scaffold(
      key: _globalKey,
      drawer: const DrawerWidget(),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  return c.isActiveImageInfo.value
                      ? const RightTriangleImageInfoWidget()
                      : const RightTriangleImageInputWidget();
                }),



                //показываем если не инфо
                Obx(() {
                  return Visibility(
                      visible: !c.isActiveImageInfo.value,
                      child: const AreaAndPerimeterWidget());
                }),
                Obx(() {
                  return Visibility(
                      visible: !c.isActiveImageInfo.value,
                      child: const MessageWidget());
                }),




                Expanded(
                  child: Obx(() {
                    return c.isActiveImageInfo.value
                        ? const DetailInfoRightWidget()
                        : const NumPadRightWidget();
                  }),
                ),
              ],
            ),
            // child: NumPadRightWidget(),
            const IconInputInfoWidget(),
            DrawerIconWidget(globalkey: _globalKey),
          ],
        ),
      ),
    );
  }
}

class IconInputInfoWidget extends StatelessWidget {
  const IconInputInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 10.h,
        right: 20.w,
        child: InkResponse(
          onTap: () {
            c.isActiveImageInfo.value = !(c.isActiveImageInfo.value);
            logger.i('c.isActiveImageInfo.value ${c.isActiveImageInfo.value}');
          },
          child: Icon(
            Icons.change_circle_outlined,
            size: AppSize.iconSize * 1.2,
            color: AppColors.text(context),
          ),
        ));
  }
}

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    Key? key,
  }) : super(key: key);

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
  const AreaAndPerimeterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
        visible: !c.isActiveSnackBar.value,
        child: SizedBox(
          width: 1.sw,
          height: AppUtils.getHeight(context) * 0.06,
          child: Stack(
            children: [
              Positioned(
                left: 20.w,
                top: 0,
                bottom: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      TranslateHelper.area,
                      style: AppStyleText.titleText(context),
                    ),
                    Text(
                      c.area.value,
                      style: AppStyleText.subText(context),
                    ),
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
                  children: [
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
