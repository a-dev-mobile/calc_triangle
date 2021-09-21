import 'package:calc_triangle/app/admob/ad_helper.dart';
import 'package:calc_triangle/app/controller/calculate/right_triangle_c.dart';
import 'package:calc_triangle/app/controller/calculate/scalene_triangle_c.dart';
import 'package:calc_triangle/app/controller/select_shape/select_shape_c.dart';
import 'package:calc_triangle/app/ui/pages/welcome/welcome_p.dart';
import 'package:calc_triangle/app/ui/widgets/right_triangle/right_triangle_w.dart';
import 'package:calc_triangle/app/ui/widgets/scalene_triangle/scalene_triangle_input_w.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

var selectShapeController = SelectShapeController.to;
var scaleneTriangleController = ScaleneTriangleController.to;
var rightTriangleController = RightTriangleController.to;

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
    return Scaffold(
      bottomNavigationBar: _isBottomBannerAdLoaded
          ? SizedBox(
              height: _bottomBannerAd.size.height.toDouble(),
              width: _bottomBannerAd.size.width.toDouble(),
              child: AdWidget(ad: _bottomBannerAd),
            )
          : null,
      // body: SafeArea(child: RightTriangleInputWidget()),
      body: SafeArea(child: getShape()),
    );
  }

  Widget getShape() {
    var activeShape = selectShapeController.activeShape;
    print('getShape $activeShape');
    if (activeShape == Shape.rightTriangle) {
      rightTriangleController.clearAll;
      return RightTriangleWidget();
    } else if (activeShape == Shape.scaleneTriangle) {
      scaleneTriangleController.clearAll;
      return ScaleneTriangleWidget();
    }
    return WelcomePage();
  }
}
