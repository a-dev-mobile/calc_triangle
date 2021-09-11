import 'package:calc_triangle/app/controller/setting/setting_c.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';
import 'package:calc_triangle/app/ui/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


late SettingController c = Get.find();
class SettingLaunchScreenWidget extends StatelessWidget {
  const SettingLaunchScreenWidget({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
    });
  }
}