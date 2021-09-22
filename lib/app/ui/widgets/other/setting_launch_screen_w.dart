import 'package:calc_triangle/app/services/serv_glob.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';
import 'package:calc_triangle/app/ui/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingLaunchScreenWidget extends StatelessWidget {
  const SettingLaunchScreenWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SwitchListTile(
        value: ServGlob.to.isShowLaunchScreen.value,
        onChanged: (val) {
          ServGlob.to.changeShowLaunchScreen();
        },
        title: Text(
          TranslateHelper.showStartupScreen,
          style: AppStyleText.titleText(context),
        ),
        subtitle: Text(
          ServGlob.to.isShowLaunchScreen.value
              ? TranslateHelper.yes
              : TranslateHelper.no,
          style: AppStyleText.subText(context),
        ),
      );
    });
  }
}
