import 'package:calc_triangle/app/constant/const.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';

import 'package:calc_triangle/app/ui/theme/app_style.dart';


import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;

    var size = MediaQuery.of(context).size;
    var w = size.width;
    var h = size.height;
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            color: isDark == true
                ? ConstColor.scaffoldDarkTheme 
                : ConstColor.scaffoldLightTheme,
            borderRadius:  const BorderRadius.only(
                bottomRight: Radius.circular(ConstDefaultDouble.radius * 2),
                topRight: Radius.circular(ConstDefaultDouble.radius * 2))),
        width: w,
        height: h,
        child: Column(
          children: [
            Container(
              color: Colors.amberAccent,
              child: Column(
                children: [
                  Container(
                    color: Colors.amber,
                    width: w,
                    height: 0.2 * h,
                  ),
                  Text(TranslateHelper.appName, style: AppStyleDrawer.textAppName),
                  Text(TranslateHelper.appNameSub,
                      style:AppStyleDrawer.textAppNameSub),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  DrawerItem(
                    icon: Icons.info_outline,
                    text: TranslateHelper.about,
                    onPressed: () {},
                  ),
                  DrawerItem(
                    icon: Icons.info_outline,
                    text: TranslateHelper.about,
                    onPressed: () {},
                  ),
                  DrawerItem(
                    icon: Icons.info_outline,
                    text: TranslateHelper.about,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 50),
              child: DrawerItem(
                icon: Icons.exit_to_app,
                text: 'Exit the app',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
  }) : super(key: key);
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: Icon(
        icon,
        size: AppStyleDrawer.sizeIcon,
        color:AppStyleDrawer.colorIcon,
      ),
      title: Text(
        text,
        style: AppStyleDrawer.textItem,
      ),
    );
  }
}
