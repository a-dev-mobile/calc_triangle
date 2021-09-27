import 'package:calc_triangle/app/config/theme/app_color.dart';
import 'package:calc_triangle/app/config/theme/app_style.dart';
import 'package:calc_triangle/app/features/calculate/controllers/right_c.dart';
import 'package:calc_triangle/app/features/calculate/controllers/scalene_c.dart';
import 'package:calc_triangle/app/shared_components/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

late var c = ScaleneTriangleController.to;

class ScaleneDetailInfoWidget extends StatelessWidget {
  const ScaleneDetailInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Obx(() {
      return Column(
        children: [
          // ItemDetail(
          //   isActive: c.isAvailableParam(RightTriangle.aCathet),
          //   leading: 'a',
          //   subtitle: 'a - catheti',
          //   title: c.aCathet.value,
          // ),
          // ItemDetail(
          //   isActive: c.isAvailableParam(RightTriangle.bCathet),
          //   leading: 'b',
          //   subtitle: 'b - catheti',
          //   title: c.bCathet.value,
          // ),
          // ItemDetail(
          //   isActive: c.isAvailableParam(RightTriangle.cHypotenuse),
          //   leading: 'c',
          //   subtitle: 'c - hypotenuse',
          //   title: c.cHypotenuse.value,
          // ),
          // ItemDetail(
          //   isActive: c.isAvailableParam(RightTriangle.hHeight),
          //   leading: 'h',
          //   subtitle: 'h - height of the triangle',
          //   title: c.hHeight.value,
          // ),
          // ItemDetail(
          //   isActive: c.isAvailableParam(RightTriangle.aAngle),
          //   leading: 'α',
          //   subtitle: 'α - acute angles in degrees',
          //   title: c.aAngle.value,
          // ),
          // ItemDetail(
          //   isActive: c.isAvailableParam(RightTriangle.bAngle),
          //   leading: 'β',
          //   subtitle: 'β - acute angles in degrees',
          //   title: c.bAngle.value,
          // ),
          // ItemDetail(
          //   isActive: c.isAvailableParam(RightTriangle.mCompCside),
          //   leading: 'm',
          //   subtitle: 'm - components of the c - hypotenuse',
          //   title: c.mCompCside.value,
          // ),
          // ItemDetail(
          //   isActive: c.isAvailableParam(RightTriangle.kCompCside),
          //   leading: 'k',
          //   subtitle: 'k - components of the c - hypotenuse',
          //   title: c.kCompCside.value,
          // ),
          AppWidgets.dividerWelcome(),
          ItemDetail(
            isActive: false,
            leading: 'A',
            subtitle: 'Area',
            title: c.area.value,
          ),
          ItemDetail(
            isActive: false,
            leading: 'P',
            subtitle: 'Perimeter',
            title: c.perimeter.value,
          ),
        ],
      );
    }));
  }
}

class ItemDetail extends StatelessWidget {
  const ItemDetail({
    Key? key,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.isActive,
  }) : super(key: key);
  final String leading;
  final String title;
  final String subtitle;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    TextStyle styleLeading;
    TextStyle styleTitle;

    if (isActive) {
      styleLeading = AppStyleText.leadingTextDetail(context);
      styleTitle = AppStyleTextImage.activeParam(context);
    } else {
      styleLeading = AppStyleText.leadingTextDetail(context);
      styleTitle = AppStyleTextImage.inActive(context);
    }

    return ListTile(
      leading: Text(leading, style: styleLeading),
      title: Text(title, style: styleTitle),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: AppColors.text(context).withOpacity(0.5)),
      ),
    );
  }
}
