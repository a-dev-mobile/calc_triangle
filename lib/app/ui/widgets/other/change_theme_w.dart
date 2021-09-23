import 'package:calc_triangle/app/constant/const_color.dart';
import 'package:calc_triangle/app/controller/setting/setting_c.dart';
import 'package:calc_triangle/app/services/global_serv.dart';

import 'package:calc_triangle/app/translations/translate_helper.dart';
import 'package:calc_triangle/app/ui/theme/app_color.dart';
import 'package:calc_triangle/app/ui/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';



class ChangeThemeWidget extends StatelessWidget {
  const ChangeThemeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isDark = GlobalServ.to.isDark.value;
      String theme =
          isDark ? TranslateHelper.darkTheme : TranslateHelper.lightTheme;

      return Column(children: [
        SizedBox(height: 20.h),
        RichText(
          text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
            TextSpan(
                text: TranslateHelper.selectTheme,
                style: AppStyleText.titleText(context)),
            TextSpan(text: theme, style: AppStyleText.subText(context))
          ]),
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleButton(
                onTap: () {
                   SettingContrl.to.setDarkTheme();
                },
                color: ConstColor.scaffoldDarkTheme,
                icon: isDark
                    ? AppStyleButton.iconActiveTheme(context)
                    : AppStyleButton.iconNotActiveTheme(context)),
            CircleButton(
                onTap: () {
                SettingContrl.to.setLightTheme();
                },
                color: ConstColor.scaffoldLightTheme,
                icon: !isDark
                    ? AppStyleButton.iconActiveTheme(context)
                    : AppStyleButton.iconNotActiveTheme(context)),
          ],
        ),
      ]);
    });
  }
}

class CircleButton extends StatelessWidget {
  const CircleButton({
    Key? key,
    required this.onTap,
    required this.color,
    required this.icon,
  }) : super(key: key);
  final Function() onTap;
  final Color color;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Container(
        width: 50.r,
        height: 50.r,
        child: icon,
        decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
                color: AppColors.contentRevers(context), width: 3.r)),
      ),
    );
  }
}
