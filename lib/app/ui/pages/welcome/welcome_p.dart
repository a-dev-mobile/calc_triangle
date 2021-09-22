import 'package:calc_triangle/app/constant/const_assets.dart';
import 'package:calc_triangle/app/constant/const_number.dart';
import 'package:calc_triangle/app/controller/setting/setting_c.dart';

import 'package:calc_triangle/app/routes/app_page.dart';
import 'package:calc_triangle/app/services/serv_glob.dart';

import 'package:calc_triangle/app/translations/translate_helper.dart';

import 'package:calc_triangle/app/ui/theme/app_color.dart';
import 'package:calc_triangle/app/ui/theme/app_size.dart';
import 'package:calc_triangle/app/ui/theme/app_style.dart';
import 'package:calc_triangle/app/ui/widgets/other/app_widgets.dart';
import 'package:calc_triangle/app/ui/widgets/other/setting_launch_screen_w.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../widgets/other/change_theme_w.dart';

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
                      height: 0.3.sh,
                      child: const ImageAppWidget(),
                    ),
                    // RightTriangleImageInfoWidget(),
                    WelcomeAppTitle(
                      fontSize: AppSize.fontSizeHeadline4(context),
                    ),
                    AppWidgets.dividerWelcome(),
                    const ChangeThemeWidget(),
                    AppWidgets.dividerWelcome(),
                    const SliderPrecisionResultWidget(),
                    const SettingLaunchScreenWidget(),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
                width: 0.8.sw, height: 0.05.sh, child: const WelcomeBtnStart()),
            const Spacer(),
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
      int precisionResult = ContrSetting.to.precisionResult.value;
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
          RichText(
            text:
                TextSpan(style: DefaultTextStyle.of(context).style, children: [
              TextSpan(text: title, style: AppStyleText.titleText(context)),
              TextSpan(text: precision, style: AppStyleText.subText(context))
            ]),
          ),
          Slider(
              value: ContrSetting.to.precisionResult.value.toDouble(),
              min: 0,
              divisions: 5,
              max: 5,
              onChanged: (double value) {
                ContrSetting.to.setPrecisionResult(value.toInt());
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
      ConstAssets.rightTriangleInfo,
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
      onPressed: () {
        Get.offAllNamed(Routes.selectShape);
        ServGlob.to.setNonFirstStartApp();
      },
      child: Text(TranslateHelper.launch, style: AppStyleButton.start(context)),
    );
  }
}

class WelcomeAppTitle extends StatelessWidget {
  const WelcomeAppTitle({
    Key? key,
    required this.fontSize,
  }) : super(key: key);

  final double fontSize;
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
            fontSize: fontSize,
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
