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
          ItemDetail(
            isActive: c.isAvailableOneParam(ScaleneTriangle.aSide),
            leading: 'a',
            subtitle: 'a - base of the triangle',
            title: c.aSide.value,
          ),
          ItemDetail(
            isActive: c.isAvailableOneParam(ScaleneTriangle.bSide),
            leading: 'b',
            subtitle: 'b - sides of the triangle',
            title: c.bSide.value,
          ),
          ItemDetail(
            isActive: c.isAvailableOneParam(ScaleneTriangle.cSide),
            leading: 'c',
            subtitle: 'c - sides of the triangle',
            title: c.cSide.value,
          ),
          ItemDetail(
            isActive: c.isAvailableOneParam(ScaleneTriangle.hHeight),
            leading: 'h',
            subtitle: 'h - height of the triangle',
            title: c.hHeight.value,
          ),
          ItemDetail(
            isActive: c.isAvailableOneParam(ScaleneTriangle.aAngle),
            leading: 'α',
            subtitle: 'α - internal angle in degrees',
            title: c.aAngle.value,
          ),
          ItemDetail(
            isActive: c.isAvailableOneParam(ScaleneTriangle.bAngle),
            leading: 'β',
            subtitle: 'β - internal angle in degrees',
            title: c.bAngle.value,
          ),
          ItemDetail(
            isActive: c.isAvailableOneParam(ScaleneTriangle.yAngle),
            leading: 'γ',
            subtitle: 'γ - internal angle in degrees',
            title: c.aAngle.value,
          ),
          AppWidgets.dividerWelcome(),
           Text(
            'Area and Perimeter',
            style: AppStyleText.titleText(context),
          ),
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
          AppWidgets.dividerWelcome(),
          Text(
            'Geometric centroid',
            style: AppStyleText.titleText(context),
          ),
          ItemDetail(
            isActive: false,
            leading: 'Xs',
            subtitle: 'X cordinate of the S point',
            title: c.xSPoint.value,
          ),
          ItemDetail(
            isActive: false,
            leading: 'Ys',
            subtitle: 'Y cordinate of the S point',
            title: c.ySPoint.value,
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
