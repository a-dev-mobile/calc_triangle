import 'package:calc_triangle/app/controller/welcome/welcome_c.dart';
import 'package:calc_triangle/app/routes/app_routes.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';


import 'package:calc_triangle/app/ui/theme/app_color.dart';
import 'package:calc_triangle/app/ui/theme/app_size.dart';
import 'package:calc_triangle/app/ui/theme/app_style.dart';
import 'package:calc_triangle/app/ui/widgets/right_triangle/widget/r_triangle_image_info_w.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import 'widgets/change_theme_w.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              TranslateHelper.settingFirstLaunch,
              style: TextStyle(color: AppColors.text(context)),
            ),
            SizedBox(
              height: 0.80.sh,
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    RightTriangleImageInfoWidget(),
                    WelcomeAppTitle(),
                    ChangeThemeWidget(),
       
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(width: 0.8.sw, height: 0.08.sh, child: const WelcomeBtnStart()),
            const Spacer()
          ],
        ),
      ),
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
        const Divider(
          color: Colors.grey,
          height: 30,
          indent: 50,
          endIndent: 50,
        ),
      ],
    );
  }
}
