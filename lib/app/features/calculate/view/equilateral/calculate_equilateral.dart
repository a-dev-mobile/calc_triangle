import 'package:calc_triangle/app/admob/ad_helper.dart';
import 'package:calc_triangle/app/features/calculate/view/equilateral/2/equilateral_main_w.dart';
import 'package:calc_triangle/app/features/calculate/view/right/2/right_main_w.dart';

import 'package:flutter/material.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class CalculateEquilateralPage extends StatefulWidget {
  const CalculateEquilateralPage({Key? key}) : super(key: key);

  @override
  _CalculateEquilateralPageState createState() => _CalculateEquilateralPageState();
}

class _CalculateEquilateralPageState extends State<CalculateEquilateralPage> {
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
    return Scaffold(
      bottomNavigationBar: _isBottomBannerAdLoaded
          ? SizedBox(
              height: _bottomBannerAd.size.height.toDouble(),
              width: _bottomBannerAd.size.width.toDouble(),
              child: AdWidget(ad: _bottomBannerAd),
            )
          : null,
      // body: SafeArea(child: RightTriangleInputWidget()),
      body: const SafeArea(child: EquilateralMain()),
    );
  }
}
