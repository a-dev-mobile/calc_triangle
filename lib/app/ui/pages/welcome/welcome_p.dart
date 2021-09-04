import 'package:calc_triangle/app/constant/const.dart';
import 'package:calc_triangle/app/controller/welcome/welcome_c.dart';
import 'package:calc_triangle/app/routes/app_routes.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';
import 'package:calc_triangle/app/ui/pages/right_triangle/widget/r_triangle_image_info_w.dart';

import 'package:calc_triangle/app/ui/theme/app_color.dart';
import 'package:calc_triangle/app/ui/theme/app_size.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var c = controller;

    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Text(
              TranslateHelper.settingFirstLaunch,
              style: TextStyle(color: AppColors.text(context)),
            ),
            const RightTriangleImageInfoWidget(),
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
            Obx(() {
              String text = c.isDarkTheme.value
                  ? TranslateHelper.darkTheme
                  : TranslateHelper.lightTheme;

              return ElevatedButton(
                  onPressed: () {
                    c.switchTheme();
                  },
                  child: Text(text));
            }),
            const Spacer(
              flex: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: ConstDefaultDouble.padding),
              child: SizedBox(
                width: size.width * 0.9,
                height: size.height * 0.08,
                child: ElevatedButton(
                  onPressed: () => Get.toNamed(Routes.SELECT_SHAPE),
                  child: Text(
                    TranslateHelper.launch,
                    style: TextStyle(
                      fontSize: AppSize.fontSizeHeadline5(context),
                      letterSpacing: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
