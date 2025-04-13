import 'dart:io';

import 'package:calc_triangle/app/config/env_config.dart';
import 'package:calc_triangle/app/config/theme/app_color.dart';
import 'package:calc_triangle/app/config/theme/app_style.dart';
import 'package:calc_triangle/app/constants/const_string.dart';
import 'package:calc_triangle/app/features/setting/controller/setting_c.dart';

import 'package:calc_triangle/app/services/global_serv.dart';
import 'package:calc_triangle/app/shared_components/app_widgets.dart';
import 'package:calc_triangle/app/shared_components/change_theme_w.dart';

import 'package:calc_triangle/app/translations/translate_helper.dart';

import 'package:calc_triangle/app/utils/logger.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

// late WelcomeController c2 = Get.find();
// late RightTriangleController c3 = Get.find();

class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TranslateHelper.setting),
        // We'll keep the AppBar here since it already exists, just add the back button
        leading: IconButton(
          icon: Platform.isIOS 
              ? Icon(CupertinoIcons.back, color: AppColors.content(context))
              : Icon(Icons.arrow_back, color: AppColors.content(context)),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            const ChangeThemeWidget(),
            const SizedBox(height: 10),
            // Removed SettingLaunchScreenWidget
            const SliderPrecisionResultWidget(),

            buildLanguage(context),

            buildEmail(context),

            buildRateApp(context),

            buildAboutApp(context),

            buildExit(context),
          ],
        ),
      ),
    );
  }

  ListTile buildEmail(BuildContext context) {
    return ListTile(
      title: Text(
        TranslateHelper.feedback,
        style: AppStyleText.textSettingItem(context),
      ),
      leading: Icon(
        Icons.feedback_outlined,
        color: AppColors.contentRevers(context),
        size: 25.sp,
      ),
      onTap: () {
        launch(emailLaunchUri.toString());
      },
    );
  }

  ListTile buildRateApp(BuildContext context) {
    return ListTile(
      title: Text(
        TranslateHelper.rateApp,
        style: AppStyleText.textSettingItem(context),
      ),
      leading: Icon(
        Icons.star_border_outlined,
        color: AppColors.contentRevers(context),
        size: 25.sp,
      ),
      onTap: () {
        launchURL();
      },
    );
  }

  ListTile buildAboutApp(BuildContext context) {
    return ListTile(
      title: Text(
        TranslateHelper.about,
        style: AppStyleText.textSettingItem(context),
      ),
      leading: Icon(
        Icons.info_outline,
        color: AppColors.contentRevers(context),
        size: 25.sp,
      ),
      onTap: () {
        Get.defaultDialog(
          title:
              '${TranslateHelper.appName}\n${TranslateHelper.version}: v2.1.0',
          backgroundColor: AppColors.content(context),
          content: Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: <Widget>[
                Text(
                  TranslateHelper.thank_you,
                  textAlign: TextAlign.center,
                  style: AppStyleText.subText(context),
                ),
                AppWidgets.dividerWelcome(),
                Text(
                  '\nAutor: Dmitriy Trofimov\ncontact: ${EnvConfig.email}',
                  style: AppStyleText.subText(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ListTile buildExit(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.exit_to_app,
        color: AppColors.contentRevers(context),
        size: 25.sp,
      ),
      onTap: () {
        AppWidgets.viewDialogExit(context);
      },
      title: Text(
        TranslateHelper.exit,
        style: AppStyleText.textSettingItem(context),
      ),
    );
  }

  Obx buildLanguage(BuildContext context) {
    return Obx(() {
      return ListTile(
        onTap: () {
          Get.defaultDialog(
            backgroundColor: AppColors.content(context),
            title: TranslateHelper.language,
            content: Column(
              children: <Widget>[
                ListTile(
                  onTap: () {
                    logger.i('english');

                    GlobalServ.to.setStorageLocale(ConstString.localeEn);
                    TranslateHelper.updateLocale(
                      const Locale(ConstString.localeEn),
                    );
                    SettingContrl.to.setEnLocation();
                    Get.back();
                  },
                  title: Text(
                    TranslateHelper.languageEn,
                    style: AppStyleText.titleText(context),
                  ),
                ),
                ListTile(
                  onTap: () {
                    GlobalServ.to.setStorageLocale(ConstString.localeRu);
                    TranslateHelper.updateLocale(
                      const Locale(ConstString.localeRu),
                    );
                    SettingContrl.to.setRusLocation();
                    Navigator.of(context).pop();
                  },
                  title: Text(
                    TranslateHelper.languageRu,
                    style: AppStyleText.titleText(context),
                  ),
                ),
              ],
            ),
          );
        },
        title: Text(
          TranslateHelper.language,
          style: AppStyleText.titleText(context),
        ),
        subtitle: Text(
          GlobalServ.to.appLocale.value == ConstString.localeRu
              ? TranslateHelper.languageRu
              : TranslateHelper.languageEn,
          style: AppStyleText.subText(context),
        ),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey.shade400),
      );
    });
  }

  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: EnvConfig.email,
    query:
        '${Uri.encodeComponent('subject')}=${Uri.encodeComponent('${TranslateHelper.feedback} -> ${TranslateHelper.appName}')}',
  );

  void launchURL() async {
    String url =
        Platform.isIOS
            ? EnvConfig.iosAppStoreUrl
            : EnvConfig.androidGooglePlayUrl;

    await canLaunch(url)
        ? await launch(url)
        : throw 'Could not launch $url';
  }
}

// Add the SliderPrecisionResultWidget to this file since we removed the welcome page
class SliderPrecisionResultWidget extends StatelessWidget {
  const SliderPrecisionResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String precision = '';
    String title = TranslateHelper.selectedPrecisionResult;
    return Obx(() {
      int precisionResult = GlobalServ.to.precisionResult.value;
      switch (precisionResult) {
        case 1:
          precision = '0.0';
          break;
        case 2:
          precision = '0.00';
          break;
        case 3:
          precision = '0.000';
          break;
        case 4:
          precision = '0.0000';
          break;
        case 5:
          precision = '0.00000';
          break;
        case 0:
        default:
          precision = '0';
      }
      return Column(
        children: <Widget>[
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <InlineSpan>[
                TextSpan(
                  text: '$title\n',
                  style: AppStyleText.titleText(context),
                ),
                TextSpan(text: precision, style: AppStyleText.subText(context)),
              ],
            ),
          ),
          Slider(
            value: GlobalServ.to.precisionResult.value.toDouble(),
            min: 0,
            divisions: 5,
            max: 5,
            onChanged: (double value) {
              GlobalServ.to.precisionResult.value = value.toInt();
              GlobalServ.to.setPrecisionResult(value.toInt());
            },
          ),
        ],
      );
    });
  }
}
