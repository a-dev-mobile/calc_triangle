import 'package:calc_triangle/app/admob/ad_helper.dart';







import 'package:flutter/material.dart';


import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'right_triangle_main_w.dart';



class CalculateRightPage extends StatefulWidget {
  const CalculateRightPage({Key? key}) : super(key: key);

  @override
  _CalculateRightPageState createState() => _CalculateRightPageState();
}

class _CalculateRightPageState extends State<CalculateRightPage> {
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
      body: const SafeArea(
          child: RightTriangleMainWidget()
      ),
    );
  }
}
