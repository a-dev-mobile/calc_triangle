import 'package:calc_triangle/app/config/theme/app_color.dart';
import 'package:calc_triangle/app/config/theme/app_size.dart';
import 'package:calc_triangle/app/config/theme/app_style.dart';
import 'package:calc_triangle/app/constants/const_assets.dart';

import 'package:calc_triangle/app/constants/const_color.dart';
import 'package:calc_triangle/app/features/calculate/controllers/right_triangle_c.dart';
import 'package:calc_triangle/app/features/calculate/controllers/scalene_triangle_c.dart';
import 'package:calc_triangle/app/features/calculate/view/right_triangle/2/right_tiangleimage_info_w.dart';
import 'package:calc_triangle/app/features/calculate/view/right_triangle/2/right_triangle_image_input_w.dart';
import 'package:calc_triangle/app/features/calculate/view/right_triangle/3/numpad_right_w.dart';
import 'package:calc_triangle/app/model/calculate_m.dart';

import 'package:calc_triangle/app/services/global_serv.dart';
import 'package:calc_triangle/app/shared_components/drawer/drawer_icon_w.dart';
import 'package:calc_triangle/app/shared_components/drawer/drawer_w.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';


import 'package:calc_triangle/app/shared_components/custom_snakbar_w.dart';
import 'package:calc_triangle/app/utils/app_type.dart';

import 'package:calc_triangle/app/utils/app_utils.dart';
import 'package:calc_triangle/app/utils/logger.dart';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

late var c = RightTriangleController.to;

class RightTriangleMainWidget extends StatelessWidget {
  const RightTriangleMainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarIconBrightness:
            GlobalServ.to.isDarkTheme() ? Brightness.light : Brightness.dark,
        statusBarColor: GlobalServ.to.isDarkTheme()
            ? ConstColor.scaffoldDarkTheme
            : ConstColor.scaffoldLightTheme, // Color for Android
        statusBarBrightness: GlobalServ.to.isDarkTheme()
            ? Brightness.dark
            : Brightness.light // Dark == white status bar -- for IOS.
        ));
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
                Obx(() {
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
                }),
                Obx(() {
                  // показ если что то не то))
                  return Visibility(
                    visible: c.isActiveSnackBar.value,
                    child: CustomMessageView(message: c.messageSnackBar.value),
                  );
                }),
                Expanded(
                  child: Container(
                    // margin: const EdgeInsets.all(ConstNumber.defaultMargin),
                    decoration: BoxDecoration(
                      color: AppColors.content(context),
                    ),
                    child: const NumPadRightWidget(),
                  ),
                ),
              ],
            ),
            Positioned(
                top: 10.h,
                right: 20.w,
                child: InkResponse(
                  onTap: () {
                    c.isActiveImageInfo.value = !(c.isActiveImageInfo.value);
                    logger.i(
                        'c.isActiveImageInfo.value ${c.isActiveImageInfo.value}');
                  },
                  child: Icon(
                    Icons.change_circle_outlined,
                    size: AppSize.iconSize * 1.2,
                    color: AppColors.text(context),
                  ),
                )),
            DrawerIconWidget(globalkey: _globalKey),
          ],
        ),
      ),
    );
  }
}
