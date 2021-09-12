import 'package:calc_triangle/app/constant/const_color.dart';
import 'package:calc_triangle/app/constant/const_string.dart';
import 'package:calc_triangle/app/controller/setting/setting_c.dart';
import 'package:calc_triangle/app/controller/welcome/welcome_c.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';
import 'package:calc_triangle/app/ui/pages/welcome/welcome_p.dart';
import 'package:calc_triangle/app/ui/theme/app_color.dart';
import 'package:calc_triangle/app/ui/widgets/other/change_theme_w.dart';
import 'package:calc_triangle/app/ui/theme/app_style.dart';
import 'package:calc_triangle/app/ui/widgets/other/app_widgets.dart';
import 'package:calc_triangle/app/ui/widgets/other/setting_launch_screen_w.dart';
import 'package:calc_triangle/app/utils/app_utils.dart';
import 'package:calc_triangle/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

late SettingController c = Get.find();
late WelcomeController c2 = Get.find();

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: AppUtils.isDark()
            ? SystemUiOverlayStyle.dark.copyWith(
                statusBarBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.light,
                statusBarColor: ConstColor.scaffoldDarkTheme)
            : SystemUiOverlayStyle.dark.copyWith(
                statusBarBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: ConstColor.scaffoldLightTheme),
        title: Text(TranslateHelper.setting),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            // const Divider(
            //   color: Colors.grey,
            // ),
            const SizedBox(height: 20),

            const ChangeThemeWidget(),
            AppWidgets.dividerWelcome(),

            Obx(() {
              return ListTile(
                onTap: () {
                  Get.defaultDialog(
                      backgroundColor: AppColors.content(context),
                      title: TranslateHelper.language,
                      content: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              printt.i('english');

                              AppUtils.setLocale(ConstString.localeEn);
                              TranslateHelper.updateLocale(
                                  const Locale(ConstString.localeEn));
                              c.setEnLocation();
                              Navigator.of(context).pop();
                            },
                            title: Text(
                              TranslateHelper.languageEn,
                              style: AppStyleText.titleText(context),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              printt.i('russsss');

                              AppUtils.setLocale(ConstString.localeRu);
                              TranslateHelper.updateLocale(
                                  const Locale(ConstString.localeRu));
                              c.setRusLocation();
                              Navigator.of(context).pop();
                            },
                            title: Text(
                              TranslateHelper.languageRu,
                              style: AppStyleText.titleText(context),
                            ),
                          ),
                        ],
                      ));
                },
                title: Text(
                  TranslateHelper.language,
                  style: AppStyleText.titleText(context),
                ),
                subtitle: Text(
                  c.isRus.value
                      ? TranslateHelper.languageRu
                      : TranslateHelper.languageEn,
                  style: AppStyleText.subText(context),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey.shade400,
                ),
              );
            }),

            AppWidgets.dividerWelcome(),

            const SettingLaunchScreenWidget(),
            AppWidgets.dividerWelcome(),
            const SliderPrecisionResultWidget(),
            AppWidgets.dividerWelcome(),
            ListTile(
              onTap: () {
                AppWidgets.viewDialogExit(context);
              },
              title: Text(
                TranslateHelper.exit,
                style: AppStyleText.titleText(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
