import 'package:calc_triangle/app/constant/const.dart';
import 'package:calc_triangle/app/controller/select_shape/select_shape_c.dart';
import 'package:calc_triangle/app/routes/app_routes.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';
import 'package:calc_triangle/app/ui/pages/right_triangle/widget/r_triangle_image_info_w.dart';
import 'package:calc_triangle/app/ui/theme/app_color.dart';
import 'package:calc_triangle/app/ui/widgets/drawer/drawer_icon_w.dart';
import 'package:calc_triangle/app/ui/widgets/drawer/drawer_w.dart';



import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectShapePage extends GetView<SelectShapeController> {
  const SelectShapePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    
    final GlobalKey<ScaffoldState> _globalkey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _globalkey,
      drawer: const DrawerWidget(),
      body: SafeArea(
        child: Stack(
          children: [
            GridView.count(
              crossAxisCount: 1,
              // crossAxisSpacing: kDefaultMargin * 2,
              padding:
                 const EdgeInsets.symmetric(vertical: ConstDefaultDouble.padding),
              mainAxisSpacing: ConstDefaultDouble.margin * 2,
              children: [
                CardShapeWidget(
                  onTap: () {
                    
                    Get.toNamed(Routes.RIGHT_TRIANGLE_INPUT);
                  },
                  shape: const RightTriangleImageInfoWidget(),
                  title: TranslateHelper.rightTriangle,
                ),
                CardShapeWidget(
                  onTap: () {
                    
                  },
                  shape: const RightTriangleImageInfoWidget(),
                  title: TranslateHelper.rightTriangle,
                ),
                CardShapeWidget(
                  onTap: () {
                    
                  },
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
        margin: const EdgeInsets.symmetric(horizontal: ConstDefaultDouble.margin * 2),
        color: AppColors.content(context),
        elevation: 5,
        shadowColor: AppColors.contentReverse(context),
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
