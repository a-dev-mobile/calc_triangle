import 'package:calc_triangle/app/constant/const_assets.dart';
import 'package:calc_triangle/app/constant/const_number.dart';
import 'package:calc_triangle/app/controller/welcome/welcome_c.dart';
import 'package:calc_triangle/app/routes/app_routes.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';

import 'package:calc_triangle/app/ui/theme/app_color.dart';
import 'package:calc_triangle/app/ui/theme/app_size.dart';
import 'package:calc_triangle/app/ui/theme/app_style.dart';
import 'package:calc_triangle/app/ui/widgets/other/app_widget.dart';
import 'package:calc_triangle/app/ui/widgets/right_triangle/widget/r_triangle_image_info_w.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:calc_triangle/main.dart';
import 'widgets/change_theme_w.dart';

late WelcomeController c = Get.find();

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: ConstNumber.defaultPadding),
              child: Text(
                TranslateHelper.settingFirstLaunch,
                style: AppStyleText.titleText(context),
              ),
            ),
            SizedBox(
              height: 0.80.sh,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 0.4.sh,
                      child: const ImageAppWidget(),
                    ),
                    // RightTriangleImageInfoWidget(),
                    const WelcomeAppTitle(),
                    AppWidget.dividerWelcome(),
                    const ChangeThemeWidget(),
                    AppWidget.dividerWelcome(),
                    SliderPrecisionResultWidget(),
                  ],
                ),
              ),
            ),
            SizedBox(
                width: 0.8.sw, height: 0.07.sh, child: const WelcomeBtnStart()),
          ],
        ),
      ),
    );
  }
}

class SliderPrecisionResultWidget extends StatelessWidget {
  const SliderPrecisionResultWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String precision;
    String title = TranslateHelper.selectedPrecisionResult;
    return Obx(() {
      int precisionResult = c.precisionResult.value;
      switch (precisionResult) {
        case 1:
          precision = '0.0';
          break;
        case 2:
          precision = '0.00';
          break;
        case 3:
          precision = '0.000';
          break;
        case 4:
          precision = '0.0000';
          break;
        case 5:
          precision = '0.00000';
          break;
        case 0:

        default:
          precision = '0';
      }

      return Column(
        children: [
          Text(
            "$title $precision",
            style: AppStyleText.subText(context),
          ),
          Slider(

              // label: precision,
              value: c.precisionResult.value.toDouble(),
              min: 0,
              divisions: 5,
              max: 5,
              onChanged: (double value) {
                c.setPrecisionResult(value.toInt());
              }),
        ],
      );
    });
  }
}

class ImageAppWidget extends StatelessWidget {
  const ImageAppWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ConstAssets.righTriangleInfo,
      fit: BoxFit.contain,
      color: AppColors.contentRevers(context),

      // Image.asset(
      //   ConstAssets.scaleneTriangleInfo,
      //   fit: BoxFit.contain,
      //   color: AppColors.contentRevers(context),
      // ),
    );
  }
}

class WelcomeBtnStart extends StatelessWidget {
  const WelcomeBtnStart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Get.toNamed(Routes.SELECT_SHAPE),
      child: Text(TranslateHelper.launch, style: AppStyleButton.start(context)),
    );
  }
}

class WelcomeAppTitle extends StatelessWidget {
  const WelcomeAppTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          TranslateHelper.appName,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.text(context),
            letterSpacing: 2.0,
            fontSize: AppSize.fontSizeHeadline4(context),
            fontWeight: FontWeight.bold,
            shadows: Get.isDarkMode == true
                //тень взависимости от темы
                ? <Shadow>[
                    const Shadow(
                      offset: Offset(5.0, 5.0),
                      blurRadius: 3.0,
                      color: Color.fromARGB(25, 255, 255, 255),
                    ),
                    const Shadow(
                      offset: Offset(5.0, 5.0),
                      blurRadius: 5.0,
                      color: Color.fromARGB(25, 0, 0, 255),
                    ),
                  ]
                : <Shadow>[
                    const Shadow(
                      offset: Offset(5.0, 5.0),
                      blurRadius: 3.0,
                      color: Color.fromARGB(25, 0, 0, 0),
                    ),
                    const Shadow(
                      offset: Offset(5.0, 5.0),
                      blurRadius: 5.0,
                      color: Color.fromARGB(25, 0, 0, 255),
                    ),
                  ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            TranslateHelper.appNameSub,
            textAlign: TextAlign.center,
            style: TextStyle(
                letterSpacing: 1.5,
                color: AppColors.text(context).withOpacity(0.8)),
          ),
        ),
      ],
    );
  }
}
