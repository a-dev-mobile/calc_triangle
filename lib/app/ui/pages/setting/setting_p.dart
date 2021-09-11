import 'package:calc_triangle/app/controller/setting/setting_c.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';
import 'package:calc_triangle/app/ui/pages/welcome/welcome_p.dart';
import 'package:calc_triangle/app/ui/pages/welcome/widgets/change_theme_w.dart';
import 'package:calc_triangle/app/ui/theme/app_style.dart';
import 'package:calc_triangle/app/ui/widgets/other/app_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

late SettingController c = Get.find();

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            AppWidget.dividerWelcome(),

            ListTile(
              title: Text(
                TranslateHelper.language,
                style: AppStyleText.titleText(context),
              ),
              subtitle: Text(
                TranslateHelper.languageEnglish,
                style: AppStyleText.subText(context),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey.shade400,
              ),
            ),

            AppWidget.dividerWelcome(),

            Obx(() {
              return SwitchListTile(
                value: c.isShowLaunchScreen.value,
                onChanged: (val) {
                  c.changeShowLaunchScreen();
                },
                title: Text(
                  TranslateHelper.showStartupScreen,
                  style: AppStyleText.titleText(context),
                ),
                subtitle: Text(
                  c.isShowLaunchScreen.value
                      ? TranslateHelper.yes
                      : TranslateHelper.no,
                  style: AppStyleText.subText(context),
                ),
              );
            }),
            AppWidget.dividerWelcome(),
            const SliderPrecisionResultWidget(),
            AppWidget.dividerWelcome(),
            ListTile(
              onTap: () {
                AppWidget.viewDialogExit(context);
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
