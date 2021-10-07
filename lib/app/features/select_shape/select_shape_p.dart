import 'package:calc_triangle/app/admob/ad_helper.dart';
import 'package:calc_triangle/app/config/routes/app_page.dart';
import 'package:calc_triangle/app/config/theme/app_color.dart';
import 'package:calc_triangle/app/constants/const_assets.dart';
import 'package:calc_triangle/app/constants/const_number.dart';
import 'package:calc_triangle/app/features/select_shape/controller/select_shape_c.dart';

import 'package:calc_triangle/app/services/global_serv.dart';

import 'package:calc_triangle/app/translations/translate_helper.dart';
import 'package:calc_triangle/app/utils/logger.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

enum Shape {
  rightTriangle,
  scaleneTriangle,
  isoscelesTriangle,
  equilateralTriangle,
  none,
}
const int maxFailedLoadAttempts = 3;

class SelectShapePage extends StatefulWidget {
  const SelectShapePage({Key? key}) : super(key: key);

  @override
  State<SelectShapePage> createState() => _SelectShapePageState();
}

class _SelectShapePageState extends State<SelectShapePage> {
  int _interstitialLoadAttempts = 0;
  InterstitialAd? _interstitialAd;

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _interstitialLoadAttempts = 0;
          _interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
          _interstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_interstitialLoadAttempts <= maxFailedLoadAttempts) {
            _createInterstitialAd();
          }
        },
      ),
    );
  }

  void _showInterstialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
    );


    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void showAd() {
    if (SelectShapeController.to.isStartAd) {
              log.w('start ad');
      _showInterstialAd();
    }
    SelectShapeController.to.incrNumberStartCalc();
  }

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
  }

  @override
  void dispose() {
    super.dispose();

    _interstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TranslateHelper.appName,
          style: TextStyle(color: AppColors.content(context)),
        ),
        actions: [buildAppBarBtnInfo(context), buildAppBarBtnSetting(context)],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CardSelectShapet(
                title: TranslateHelper.right_triangle,
                patchAssets1: ConstAssetsImageRaster.rightTriangleInfo,
                enterParameter: TranslateHelper.enterTwoParameters,
                info: TranslateHelper.right_info,
                onTap: () {
                  showAd();
                  GlobalServ.to.aciveShape = Shape.rightTriangle;
                  Get.toNamed(Routes.calculateRight);
                },
              ),
            ),
            Expanded(
              child: CardSelectShapet(
                title: TranslateHelper.scalene_triangle,
                patchAssets1: ConstAssetsImageRaster.scaleneTriangleInfo,
                enterParameter: TranslateHelper.enterThreeParameters,
                info: TranslateHelper.scalene_info,
                onTap: () {
                  showAd();
                  GlobalServ.to.aciveShape = Shape.scaleneTriangle;
                  Get.toNamed(Routes.calculateScalene);
                },
              ),
            ),
            Expanded(
              child: CardSelectShapet(
                title: TranslateHelper.isosceles_triangle,
                patchAssets1: ConstAssetsImageRaster.isoscelesTriangleInfo,
                enterParameter: TranslateHelper.enterTwoParameters,
                info: TranslateHelper.isosceles_info,
                onTap: () {
          showAd();
                  GlobalServ.to.aciveShape = Shape.isoscelesTriangle;
                  Get.toNamed(Routes.calculateIsosceles);
                },
              ),
            ),
            Expanded(
              child: CardSelectShapet(
                title: TranslateHelper.equilateral_triangle,
                patchAssets1: ConstAssetsImageRaster.equilateralTriangleInfo,
                enterParameter: TranslateHelper.enterOneParameters,
                info: TranslateHelper.equilateral_info,
                onTap: () {
      showAd();
                  GlobalServ.to.aciveShape = Shape.equilateralTriangle;
                  Get.toNamed(Routes.calculateEquilateral);
                },
              ),
            ),
          ],
        ),

        //   ],
      ),
    );
  }

  IconButton buildAppBarBtnSetting(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.toNamed(Routes.setting);
        },
        icon: Icon(Icons.settings, color: AppColors.content(context)));
  }

  IconButton buildAppBarBtnInfo(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.defaultDialog(
              titlePadding: const EdgeInsets.all(16),
              contentPadding: const EdgeInsets.all(16),
              backgroundColor: AppColors.content(context),
              title: TranslateHelper.you_calculate,
              content: Text(TranslateHelper.dialog_calculate));
        },
        icon: Icon(Icons.announcement, color: AppColors.content(context)));
  }
}

class CardSelectShapet extends StatelessWidget {
  const CardSelectShapet({
    Key? key,
    required this.title,
    required this.patchAssets1,
    required this.enterParameter,
    required this.info,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final String info;
  final String enterParameter;
  final Function onTap;
  final String patchAssets1;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(ConstNumber.defaultMargin),
      elevation: 3,
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Image.asset(
                  patchAssets1,
                  color: AppColors.contentRevers(context),
                )),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    info,
                    style: TextStyle(
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    enterParameter,
                    style: TextStyle(fontSize: 15.sp, color: Colors.grey),
                  ),
                ],
              ),
            ),
            // Align(alignment: Alignment.topCenter, child: Icon(Icons.info_outline,color: AppColors.contentRevers(context),))
          ],
        ),
      ),
    );
  }
}
