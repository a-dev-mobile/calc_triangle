import 'package:calc_triangle/app/admob/ad_helper.dart';
import 'package:calc_triangle/app/controller/select_shape/select_shape_c.dart';
import 'package:calc_triangle/app/ui/widgets/drawer/drawer_icon_w.dart';
import 'package:calc_triangle/app/ui/widgets/drawer/drawer_w.dart';
import 'package:calc_triangle/app/utils/app_utils.dart';
import 'package:calc_triangle/app/ui/widgets/right_triangle/right_triangle_input_w.dart';
import 'package:calc_triangle/main.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    Shapes selectedFigure = Shapes.values[AppUtils.activeShapeIndex()];

    printt.i('selectedFigure $selectedFigure');

    // if (selectedFigure == Shapes.rightTriangle) {
    //   showCalculation = const RightTriangleInputWidget();
    // } else if (selectedFigure == Shapes.scaleneTriangle) {
    //   showCalculation = ScaleneTrianglePage();
    // } else {
    //   showCalculation = ScaleneTrianglePage();
    // }

    return Scaffold(
      bottomNavigationBar: _isBottomBannerAdLoaded
          ? SizedBox(
              height: _bottomBannerAd.size.height.toDouble(),
              width: _bottomBannerAd.size.width.toDouble(),
              child: AdWidget(ad: _bottomBannerAd),
            )
          : null,
      body: SafeArea(child: RightTriangleInputWidget()),
    );
  }
}
/*    final GlobalKey<ScaffoldState> _globalkey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _globalkey,
      drawer: DrawerWidget(),
      body: SafeArea(
        child: Stack(
          children: [
            GridView.count(
              crossAxisCount: 1,
              // crossAxisSpacing: kDefaultMargin * 2,
              padding: const EdgeInsets.symmetric(
                  vertical: ConstNumber.defaultPadding),
              mainAxisSpacing: ConstNumber.defaultMargin * 2,
              children: [
                CardShapeWidget(
                  onTap: () {
                    c.click(Shapes.rightTriangle);
                  },
                  shape: Image.asset(
                    ConstAssets.righTriangleInfo,
                    fit: BoxFit.contain,
                    color: AppColors.contentRevers(context),
                  ),
                  // shape: const RightTriangleImageInfoWidget(),
                  title: TranslateHelper.rightTriangle,
                ),
                CardShapeWidget(
                  onTap: () {
                    c.click(Shapes.scaleneTriangle);
                  },
                  shape: Image.asset(
                    ConstAssets.scaleneTriangleInfo,
                    fit: BoxFit.contain,
                    color: AppColors.contentRevers(context),
                  ),
                  title: TranslateHelper.rightTriangle,
                ),
                CardShapeWidget(
                  onTap: () {},
                  shape: const RightTriangleImageInfoWidget(),
                  title: TranslateHelper.rightTriangle,
                ),
              ],
            ),
            DrawerIconWidget(globalkey: _globalkey),*/
