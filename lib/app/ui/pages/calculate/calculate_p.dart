import 'package:calc_triangle/app/admob/ad_helper.dart';
import 'package:calc_triangle/app/controller/calculate/calculate_c.dart';
import 'package:calc_triangle/app/controller/select_shape/select_shape_c.dart';
import 'package:calc_triangle/app/ui/theme/app_utils.dart';
import 'package:calc_triangle/app/ui/widgets/right_triangle/right_triangle_input_w.dart';
import 'package:calc_triangle/app/ui/widgets/scalene_triangle/scalene_triangle_w.dart';
import 'package:calc_triangle/main.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CalculatePage extends StatefulWidget {
  const CalculatePage({Key? key}) : super(key: key);

  @override
  _CalculatePageState createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  late BannerAd _bottomBannerAd;
  bool _isBottomBannerAdLoaded = false;

  void _createBottomBannerAd() {
    _bottomBannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBottomBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _bottomBannerAd.load();
  }

  @override
  void initState() {
    super.initState();
    _createBottomBannerAd();
  }

  @override
  void dispose() {
    super.dispose();
    _bottomBannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CalculateController c = Get.find();
    Widget showCalculation;
    Shapes selectedFigure = Shapes.values[AppUtils.activeShapeIndex()];

    printt.i('selectedFigure $selectedFigure');

    if (selectedFigure == Shapes.rightTriangle) {
      showCalculation = RightTriangleInputWidget();
    } else if (selectedFigure == Shapes.scaleneTriangle) {
      showCalculation = ScaleneTrianglePage();
    } else {
      showCalculation = ScaleneTrianglePage();
    }

    return Scaffold(
      bottomNavigationBar: _isBottomBannerAdLoaded
          ? SizedBox(
              height: _bottomBannerAd.size.height.toDouble(),
              width: _bottomBannerAd.size.width.toDouble(),
              child: AdWidget(ad: _bottomBannerAd),
            )
          : null,
      body: SafeArea(child: showCalculation),
    );
  }
}
