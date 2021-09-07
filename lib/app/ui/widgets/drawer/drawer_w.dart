import 'package:calc_triangle/app/constant/const_assets.dart';
import 'package:calc_triangle/app/constant/const_number.dart';
import 'package:calc_triangle/app/constant/const_string.dart';
import 'package:calc_triangle/app/routes/app_routes.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';
import 'package:calc_triangle/app/ui/theme/app_color.dart';

import 'package:calc_triangle/app/ui/theme/app_style.dart';
import 'package:calc_triangle/app/ui/widgets/other/app_widget.dart';
import 'package:calc_triangle/main.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

class DrawerWidget extends StatelessWidget {
  late BuildContext _context;

  DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _context = context;
    return _buildDrawer();
  }

  _buildDrawer() {
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.contentRevers(_context),
            // boxShadow: [BoxShadow(color: AppColors.content(_context))]),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    color: Colors.amber,
                    height: 0.2.sh,
                    width: 1.sw,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(TranslateHelper.appName,
                            style: AppStyleDrawer.textAppName(_context)),
                        Text(TranslateHelper.appNameSub,
                            style: AppStyleDrawer.textAppNameSub(_context)),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  DrawerRow(
                      onTap: () {
                        // Get.toNamed(Routes.SELECT_SHAPE);
                        Navigator.of(_context).pop();
                      },
                      icon: Icons.home,
                      msg: TranslateHelper.home),
                  AppWidget.dividerDrawer(),
                  DrawerRow(
                      onTap: () {
                        Get.toNamed(Routes.SETTING);
                      },
                      icon: Icons.settings,
                      msg: TranslateHelper.setting),
                  AppWidget.dividerDrawer(),
                  DrawerRow(
                      onTap: () {
                        Share.share(
                            '*${TranslateHelper.appName}*\n${TranslateHelper.shareDetails}\n${ConstString.playStoreUrl}');
                      },
                      icon: Icons.share,
                      msg: TranslateHelper.shareApp),
                  AppWidget.dividerDrawer(),
                  DrawerRow(
                      onTap: () {},
                      icon: Icons.info_outline,
                      msg: TranslateHelper.about),
                  // Spacer(),
                  AppWidget.dividerDrawer(),
                  DrawerRow(
                      onTap: () {},
                      icon: Icons.exit_to_app,
                      msg: TranslateHelper.exit),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerRow extends StatelessWidget {
  const DrawerRow({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.msg,
  }) : super(key: key);
  final IconData icon;
  final Function() onTap;
  final String msg;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: AppStyleDrawer.iconSize,
        color: AppStyleDrawer.iconColor(context),
      ),
      title: Text(
        msg,
        style: AppStyleDrawer.textItem(context),
      ),
    );
  }
}

class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width - 40.w, 0);
    path.quadraticBezierTo(
        size.width, size.height / 4, size.width, size.height / 2);
    path.quadraticBezierTo(size.width, size.height - (size.height / 4),
        size.width - 40.w, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

// class DrawerItem extends StatelessWidget {
//   const DrawerItem({
//     Key? key,
//     required this.icon,
//     required this.text,
//     required this.onPressed,
//   }) : super(key: key);
//   final IconData icon;
//   final String text;
//   final VoidCallback onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: onPressed,
//       leading: Icon(
//         icon,
//         size: AppStyleDrawer.sizeIcon,
//         color: AppStyleDrawer.colorIcon,
//       ),
//       title: Text(
//         text,
//         style: AppStyleDrawer.textItem(context),
//       ),
//     );
//   }

