import 'package:calc_triangle/app/config/routes/app_page.dart';
import 'package:calc_triangle/app/config/theme/app_color.dart';
import 'package:calc_triangle/app/config/theme/app_style.dart';
import 'package:calc_triangle/app/constants/const_assets.dart';
import 'package:calc_triangle/app/constants/const_color.dart';
import 'package:calc_triangle/app/constants/const_number.dart';

import 'package:calc_triangle/app/shared_components/image_info_w.dart';
import 'package:calc_triangle/app/services/global_serv.dart';

import 'package:calc_triangle/app/shared_components/drawer/drawer_icon_w.dart';
import 'package:calc_triangle/app/shared_components/drawer/drawer_w.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';
import 'package:calc_triangle/app/utils/app_utils.dart';

import 'package:calc_triangle/app/utils/logger.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

enum Shape {
  rightTriangle,
  scaleneTriangle,
  none,
}

class SelectShapePage extends StatelessWidget {
  const SelectShapePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TranslateHelper.appName,
          style: TextStyle(color: AppColors.contentRevers(context)),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.setting);
              },
              icon:
                  Icon(Icons.settings, color: AppColors.contentRevers(context)))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              CardSelectShapet(
                title: TranslateHelper.right_triangle,
                titleDialog: TranslateHelper.title_dialog_calculate,
                dialogText: TranslateHelper.dialog_calculate_righ,
                patchAssets1: ConstAssetsImageRaster.rightTriangleInfo,
              
              ),
              CardSelectShapet(
                title: TranslateHelper.scalene_triangle,
                titleDialog: TranslateHelper.title_dialog_calculate,
                dialogText: TranslateHelper.dialog_calculate_scalene,
                patchAssets1: ConstAssetsImageRaster.scaleneTriangleInfo,
              
              ),
            ],
          ),
        ),

        //   ],
      ),
    );
  }
}

class CardSelectShapet extends StatelessWidget {
  const CardSelectShapet({
    Key? key,
    required this.title,
    required this.titleDialog,
    required this.dialogText,
    required this.patchAssets1,
  }) : super(key: key);
  final String title;
  final String titleDialog;
  final String dialogText;
  final String patchAssets1;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(ConstNumber.defaultMargin),
      elevation: 5,
      child: InkWell(
        onTap: () {
          if (title == TranslateHelper.right_triangle) {
            GlobalServ.to.aciveShape = Shape.rightTriangle;
          } else if (title == TranslateHelper.scalene_triangle) {
            GlobalServ.to.aciveShape = Shape.scaleneTriangle;
          }
            Get.toNamed(Routes.calculate);
        },
        child: SizedBox(
          height: 0.4.sh,
          width: 1.sw,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 30.sp),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Get.defaultDialog(
                              titlePadding: const EdgeInsets.all(16),
                              contentPadding: const EdgeInsets.all(16),
                              backgroundColor: AppColors.content(context),
                              title: titleDialog,
                              content: Text(dialogText));
                        },
                        icon: Icon(
                          Icons.help_outline,
                          size: 50.sp,
                          color: AppColors.contentRevers(context),
                        ))
                  ],
                ),
                Expanded(
                    child: Image.asset(
                  patchAssets1,
                  color: AppColors.contentRevers(context),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

  
        
        // child: Stack(
        //   children: [
        //     GridView.count(
        //       crossAxisCount: 2,
        //       // children: [
        //       //   InkWell(
        //       //       onTap: () {
        //       //         // SelectShapeController.to.initWidgetControllerPath();
        //       //         logger.i(
        //       //             'Get.offAllNamed(Routes.calculate, arguments: Shape.rightTriangle);');
        //       //         GlobalServ.to.aciveShape = Shape.rightTriangle;
        //       //         Get.offAllNamed(Routes.calculate);
        //       //       },
        //       //       child: const ImageInfoWidget(
        //       //         patchAsset: ConstAssetsImageRaster.rightTriangleInfo,
        //       //       )),
        //       //   InkWell(
        //       //       onTap: () {
        //       //         logger.i(
        //       //             'Get.offAllNamed(Routes.calculate, arguments: Shape.scaleneTriangle);');
        //       //         GlobalServ.to.aciveShape = Shape.scaleneTriangle;
        //       //         Get.offAllNamed(Routes.calculate);
        //       //       },
        //       //       child: const ImageInfoWidget(
        //       //         patchAsset: ConstAssetsImageRaster.scaleneTriangleInfo,
        //       //       )),
        //       // ],
        //     ),