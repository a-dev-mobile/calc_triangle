import 'package:calc_triangle/app/constant/const_assets.dart';
import 'package:calc_triangle/app/constant/const_number.dart';
import 'package:calc_triangle/app/controller/select_shape/select_shape_c.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';

import 'package:calc_triangle/app/ui/theme/app_color.dart';
import 'package:calc_triangle/app/ui/widgets/drawer/drawer_icon_w.dart';
import 'package:calc_triangle/app/ui/widgets/drawer/drawer_w.dart';
import 'package:calc_triangle/app/ui/widgets/right_triangle/widget/r_triangle_image_info_w.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectShapePage extends StatelessWidget {
  const SelectShapePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SelectShapeController c = Get.find();
    final GlobalKey<ScaffoldState> _globalkey = GlobalKey<ScaffoldState>();
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
            DrawerIconWidget(globalkey: _globalkey),
          ],
        ),
      ),
    );
  }
}

class CardShapeWidget extends StatelessWidget {
  const CardShapeWidget({
    Key? key,
    required this.onTap,
    required this.shape,
    required this.title,
  }) : super(key: key);

  final void Function() onTap;
  final Widget shape;
  final String title;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.4,
      child: Card(
        margin: const EdgeInsets.symmetric(
            horizontal: ConstNumber.defaultMargin * 2),
        color: AppColors.content(context),
        elevation: 5,
        shadowColor: AppColors.text(context),
        child: GestureDetector(
          onTap: onTap,
          child: Column(
            children: [shape, Text(title)],
          ),
        ),
      ),
    );
  }
}
