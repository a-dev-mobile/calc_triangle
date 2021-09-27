import 'package:calc_triangle/app/admob/ad_helper.dart';
import 'package:calc_triangle/app/features/calculate/view/right_triangle/2/right_main_w.dart';
import 'package:calc_triangle/app/features/calculate/view/scalene_triangle/2/scalene_triangle_main_w.dart';
import 'package:calc_triangle/app/features/select_shape/select_shape_p.dart';
import 'package:calc_triangle/app/features/welcome/welcome_p.dart';
import 'package:calc_triangle/app/model/calculate_m.dart';

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

  Widget getShapeCalculate() {
    final Shape shape = Get.arguments;

    switch (shape) {
      case Shape.rightTriangle:
        return const RightTriangleMainWidget();
      case Shape.scaleneTriangle:
        return const ScaleneTriangleMainWidget();
      case Shape.none:
        return const WelcomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _isBottomBannerAdLoaded
          ? SizedBox(
              height: _bottomBannerAd.size.height.toDouble(),
              width: _bottomBannerAd.size.width.toDouble(),
              child: AdWidget(ad: _bottomBannerAd),
            )
          : null,
      // body: SafeArea(child: RightTriangleInputWidget()),
      body: SafeArea(child: getShapeCalculate()),
    );
  }
}
