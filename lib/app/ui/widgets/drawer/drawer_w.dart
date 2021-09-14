import 'package:calc_triangle/app/constant/const_assets.dart';
import 'package:calc_triangle/app/constant/const_string.dart';
import 'package:calc_triangle/app/routes/app_routes.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';
import 'package:calc_triangle/app/ui/pages/welcome/welcome_p.dart';
import 'package:calc_triangle/app/ui/theme/app_color.dart';

import 'package:calc_triangle/app/ui/theme/app_style.dart';
import 'package:calc_triangle/app/ui/widgets/other/app_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  late BuildContext _context;

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
            color: AppColors.content(_context),
            // boxShadow: [BoxShadow(color: AppColors.content(_context))]),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 0.05.sh),
                    child: SizedBox(
                      height: 0.1.sh,
                      width: 1.sw,
                      child: Center(
                        child: WelcomeAppTitle(
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                  ),
                  AppWidgets.dividerDrawer(),
                  // SizedBox(height: 30.h),
                  DrawerRow(
                      onTap: () {
                        // Get.toNamed(Routes.SELECT_SHAPE);
                        Navigator.of(_context).pop();
                      },
                      icon: Icons.home,
                      msg: TranslateHelper.home),
                  AppWidgets.dividerDrawer(),
                  DrawerRow(
                      onTap: () {
                        Navigator.of(_context).pop();
                        Get.toNamed(Routes.SETTING);
                      },
                      icon: Icons.settings,
                      msg: TranslateHelper.setting),
                  AppWidgets.dividerDrawer(),
                  DrawerRow(
                      onTap: () {
                        Share.share(
                            '*${TranslateHelper.appName}*\n${TranslateHelper.shareDetails}\n${ConstString.playStoreUrl}');
                      },
                      icon: Icons.share,
                      msg: TranslateHelper.shareApp),
                  AppWidgets.dividerDrawer(),
                  DrawerRow(
                      onTap: () {
                        launchURL();
                      },
                      icon: Icons.rate_review,
                      msg: TranslateHelper.rateApp),

                  AppWidgets.dividerDrawer(),

                  DrawerRow(
                      onTap: () {
                        launch(emailLaunchUri.toString());
                      },
                      icon: Icons.feedback,
                      msg: TranslateHelper.feedback),

                  AppWidgets.dividerDrawer(),

                  DrawerRow(
                      onTap: () {
                        Get.defaultDialog(
                            title: TranslateHelper.about,
                            backgroundColor: AppColors.content(context),
                            content: Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                children: [
                                  Text(
                                    'App is created using flutter',
                                    style: AppStyleText.subText(context),
                                  ),
                                  AppWidgets.dividerWelcome(),
                                  Text(
                                    'Libraries:',
                                    style: AppStyleText.subText(context),
                                  ),
                                  SizedBox(height: 20.h),
                                  Text(
                                    '''
flutter_screenutil: ^5.0.0+2
get: ^4.3.8
get_storage: ^2.0.3
logger: ^1.1.0
google_mobile_ads: ^0.13.4
share: ^2.0.4
url_launcher: ^6.0.10
''',
                                    style: AppStyleText.subText(context),
                                  ),
                                ],
                              ),
                            ));
                      },
                      icon: Icons.info_outline,
                      msg: TranslateHelper.about),
                  // Spacer(),
                  AppWidgets.dividerDrawer(),
                  DrawerRow(
                      onTap: () {
                        AppWidgets.viewDialogExit(_context);
                      },
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

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

final Uri emailLaunchUri = Uri(
  scheme: 'mailto',
  path: ConstString.email,
  query: encodeQueryParameters(<String, String>{
    'subject': '${TranslateHelper.feedback} -> ${TranslateHelper.appName}'
  }),
);
void launchURL() async => await canLaunch(ConstString.playStoreUrl)
    ? await launch(ConstString.playStoreUrl)
    : throw 'Could not launch ${ConstString.playStoreUrl}';

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
