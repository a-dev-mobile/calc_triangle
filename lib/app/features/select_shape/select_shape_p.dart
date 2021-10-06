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
  equilateralTriangle,
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
        actions: [buildAppBarBtnInfo(context), buildAppBarBtnSetting(context)],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CardSelectShapet(
                title: TranslateHelper.right_triangle,
                patchAssets1: ConstAssetsImageRaster.rightTriangleInfo,
                enterParameter: TranslateHelper.enterTwoParameters,
                info: TranslateHelper.right_info,
              ),
            ),
            Expanded(
              child: CardSelectShapet(
                title: TranslateHelper.scalene_triangle,
                patchAssets1: ConstAssetsImageRaster.scaleneTriangleInfo,
                enterParameter: TranslateHelper.enterThreeParameters,
                info: TranslateHelper.scalene_info,
              ),
            ),
            Expanded(
              child: CardSelectShapet(
                title: TranslateHelper.isosceles_triangle,
                patchAssets1: ConstAssetsImageRaster.isoscelesTriangleInfo,
                enterParameter: TranslateHelper.enterTwoParameters,
                info: TranslateHelper.isosceles_info,
              ),
            ),
            Expanded(
              child: CardSelectShapet(
                title: TranslateHelper.equilateral_triangle,
                patchAssets1: ConstAssetsImageRaster.equilateralTriangleInfo,
                enterParameter: TranslateHelper.enterOneParameters,
                info: TranslateHelper.equilateral_info,
              ),
            ),
          ],
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
        icon: Icon(Icons.announcement, color: AppColors.content(context)));
  }
}

class CardSelectShapet extends StatelessWidget {
  const CardSelectShapet({
    Key? key,
    required this.title,
    required this.patchAssets1,
    required this.enterParameter,
    required this.info,
  }) : super(key: key);
  final String title;
  final String info;
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
          } else if (title == TranslateHelper.equilateral_triangle) {
            GlobalServ.to.aciveShape = Shape.equilateralTriangle;
            Get.toNamed(Routes.calculateEquilateral);
          } else if (title == TranslateHelper.isosceles_triangle) {
            GlobalServ.to.aciveShape = Shape.isoscelesTriangle;
            Get.toNamed(Routes.calculateIsosceles);
          }
        },
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Image.asset(
                  patchAssets1,
                  color: AppColors.contentRevers(context),
                )),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    info,
                    style: TextStyle(
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    enterParameter,
                    style: TextStyle(fontSize: 15.sp, color: Colors.grey),
                  ),
                ],
              ),
            ),
            // Align(alignment: Alignment.topCenter, child: Icon(Icons.info_outline,color: AppColors.contentRevers(context),))
          ],
        ),
      ),
    );
  }
}
