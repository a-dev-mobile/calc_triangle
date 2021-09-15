import 'package:calc_triangle/app/constant/const_color.dart';
import 'package:calc_triangle/app/controller/calculate/right_triangle_c.dart';
import 'package:calc_triangle/app/ui/theme/app_color.dart';
import 'package:calc_triangle/app/ui/widgets/drawer/drawer_icon_w.dart';
import 'package:calc_triangle/app/ui/widgets/drawer/drawer_w.dart';
import 'package:calc_triangle/app/ui/widgets/drawer/snackbar/custom_snakbar_w.dart';
import 'package:calc_triangle/app/ui/widgets/numpad/numpad_w.dart';
import 'package:calc_triangle/app/ui/widgets/other/app_widgets.dart';
import 'package:calc_triangle/app/utils/app_utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'widget/r_triangle_image_input_w.dart';

late RightTriangleController c = Get.find();

class RightTriangleInputWidget extends StatelessWidget {
  RightTriangleInputWidget({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarIconBrightness:
            AppUtils.isDark() ? Brightness.light : Brightness.dark,
        statusBarColor: AppUtils.isDark()
            ? ConstColor.scaffoldDarkTheme
            : ConstColor.scaffoldLightTheme, // Color for Android
        statusBarBrightness: AppUtils.isDark()
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
                const RightTriangleImageInputWidget(),
                Obx(() {
                  return Visibility(
                    visible: !c.isActiveSnackBar.value,
                    child: SizedBox(
                      width: AppUtils.getWidth(context),
                      height: AppUtils.getHeight(context) * 0.05,
                      child: Align(
                        child: Icon(Icons.done,color: ConstColor.secondary,size: 50.sp,),
                        alignment: Alignment.center,
                      ),
                    ),
                  );
                }),
                Obx(() {
                  // показ если что то не то))
                  return Visibility(
                    visible: c.isActiveSnackBar.value,
                    child: CustomSnackBar(message: c.messageSnackBar.value),
                  );
                }),
                Expanded(
                  child: Container(
                    // margin: const EdgeInsets.all(ConstNumber.defaultMargin),
                    decoration: BoxDecoration(
                      color: AppColors.content(context),
                    ),
                    child: const NumPad(),
                  ),
                ),
              ],
            ),
            DrawerIconWidget(globalkey: _globalKey),
            // Obx(() {
            //   c.isDeg.value
            //       ? textConvert = ConstString.degConvert
            //       : textConvert = ConstString.degMinSecConvert;
            //   return Positioned(top: 10.h, right: 10.w, child: Text(textConvert,style: AppStyleText.convertText(context),));
            // })
          ],
        ),
      ),
    );
  }
}
