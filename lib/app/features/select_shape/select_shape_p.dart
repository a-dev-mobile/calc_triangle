import 'package:calc_triangle/app/config/routes/app_page.dart';
import 'package:calc_triangle/app/config/theme/app_color.dart';
import 'package:calc_triangle/app/constants/const_assets.dart';
import 'package:calc_triangle/app/constants/const_number.dart';

import 'package:calc_triangle/app/services/global_serv.dart';

import 'package:calc_triangle/app/translations/translate_helper.dart';


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

enum Shape {
  rightTriangle,
  scaleneTriangle,
  isoscelesTriangle,
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
          style: TextStyle(color: AppColors.content(context)),
        ),
        actions: [
          buildAppBarBtnInfo(context),
          buildAppBarBtnSetting(context)
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          child: Column(
            children: [
              CardSelectShapet(
                title: TranslateHelper.right_triangle,
                patchAssets1: ConstAssetsImageRaster.rightTriangleInfo,
                enterParameter: TranslateHelper.enterTwoParameters,
              ),
              CardSelectShapet(
                title: TranslateHelper.scalene_triangle,
                patchAssets1: ConstAssetsImageRaster.scaleneTriangleInfo,
                enterParameter: TranslateHelper.enterThreeParameters,
              ),
              CardSelectShapet(
                title: TranslateHelper.isosceles_triangle,
                patchAssets1: ConstAssetsImageRaster.isoscelesTriangleInfo,
                enterParameter: TranslateHelper.enterTwoParameters,
              ),
                CardSelectShapet(
                title: TranslateHelper.equilateral_triangle,
                patchAssets1: ConstAssetsImageRaster.equilateralTriangleInfo,
                enterParameter: TranslateHelper.enterOneParameters,
              ),
            ],
          ),
        ),

        //   ],
      ),
    );
  }

  IconButton buildAppBarBtnSetting(BuildContext context) {
    return IconButton(
            onPressed: () {
              Get.toNamed(Routes.setting);
            },
            icon: Icon(Icons.settings, color: AppColors.content(context)));
  }

  IconButton buildAppBarBtnInfo(BuildContext context) {
    return IconButton(
            onPressed: () {
              Get.defaultDialog(
                  titlePadding: const EdgeInsets.all(16),
                  contentPadding: const EdgeInsets.all(16),
                  backgroundColor: AppColors.content(context),
                  title: TranslateHelper.you_calculate,
                  content: Text(TranslateHelper.dialog_calculate));
            },
            icon: Icon(Icons.info, color: AppColors.content(context)));
  }
}

class CardSelectShapet extends StatelessWidget {
  const CardSelectShapet({
    Key? key,
    required this.title,
    required this.patchAssets1,
    required this.enterParameter,
  }) : super(key: key);
  final String title;
  final String enterParameter;

  final String patchAssets1;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(ConstNumber.defaultMargin),
      elevation: 3,
      child: InkWell(
        onTap: () {
          //TODO при добавлении нового треугольника изменить
          if (title == TranslateHelper.right_triangle) {
            GlobalServ.to.aciveShape = Shape.rightTriangle;
            Get.toNamed(Routes.calculateRight);
          } else if (title == TranslateHelper.scalene_triangle) {
            GlobalServ.to.aciveShape = Shape.scaleneTriangle;
            Get.toNamed(Routes.calculateScalene);
          }
          else if (title == TranslateHelper.isosceles_triangle) {
            GlobalServ.to.aciveShape = Shape.isoscelesTriangle;
            Get.toNamed(Routes.calculateScalene);
          }
        },
        child: SizedBox(
          height: 0.4.sh,
          width: 1.sw,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 30.sp),
                ),
                Text(
                  enterParameter,
                  style: TextStyle(fontSize: 15.sp, color: Colors.grey),
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