import 'package:calc_triangle/app/constant/const.dart';
import 'package:calc_triangle/app/controller/welcome/welcome_c.dart';
import 'package:calc_triangle/app/ui/theme/app_color.dart';
import 'package:calc_triangle/app/ui/theme/app_style.dart';
import 'package:calc_triangle/app/ui/theme/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChangeThemeWidget extends StatelessWidget {
  const ChangeThemeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WelcomeController controller = Get.find();
    return Column(
      children: [
        SizedBox(height: 20.h),
        const Text(
          ' Select the theme of app ',
        ),
        SizedBox(height: 20.h),
        Obx(
          () {
            bool isDark = controller.isDarkTheme.value;

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleButton(
                    onTap: () {
                      controller.setDarkTheme();
                    },
                    color: ConstColor.scaffoldDarkTheme,
                    icon: isDark
                        ? AppStyleButton.iconActiveTheme(context)
                        : AppStyleButton.iconNotActiveTheme(context)),
                CircleButton(
                    onTap: () {
                      controller.setLightTheme();
                    },
                    color: ConstColor.scaffoldLightTheme,
                    icon: !isDark
                        ? AppStyleButton.iconActiveTheme(context)
                        : AppStyleButton.iconNotActiveTheme(context)),
              ],
            );
          },
        )
      ],
    );
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
