import 'package:calc_triangle/app/config/theme/app_color.dart';
import 'package:calc_triangle/app/constants/const_assets.dart';
import 'package:calc_triangle/app/features/calculate/controllers/equilateral_c.dart';

import 'package:calc_triangle/app/services/global_serv.dart';
import 'package:calc_triangle/app/shared_components/detail_info/area_perim.dart';
import 'package:calc_triangle/app/shared_components/detail_info/detail_item.dart';
import 'package:calc_triangle/app/shared_components/detail_info/detail_title.dart';
import 'package:calc_triangle/app/shared_components/image_info_w.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';
import 'package:calc_triangle/app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

late var c = EquilateralTriangleController.to;

class EquilateralDetail extends StatelessWidget {
  const EquilateralDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Column(
          children: [
            StickyHeader(
              header: Container(
                color: AppColors.content(context),
                child: Column(
                  children: [
                    const ImageInfoWidget(
                        patchAsset:
                            ConstAssetsImageRaster.equilateralTriangleInfo),
                    TextTitleDetail(text: TranslateHelper.sides_height_angles),
                  ],
                ),
              ),
              content: const EquilateralSidesAngles(),
            ),
            StickyHeader(
              header: Container(
                color: AppColors.content(context),
                child: Column(
                  children: [
                    const ImageInfoWidget(
                        patchAsset:
                            ConstAssetsImageRaster.equilateralTriangleAP),
                    TextTitleDetail(text: TranslateHelper.area_perim),
                  ],
                ),
              ),
              content: AreaPerimeter(
                area: c.area.value,
                perimeter: c.perimeter.value,
              ),
            ),
            StickyHeader(
                header: Container(
                  color: AppColors.content(context),
                  child: Column(
                    children: [
                      const ImageInfoWidget(
                          patchAsset:
                              ConstAssetsImageRaster.equilateralTriangleS),
                      TextTitleDetail(
                          text: TranslateHelper.mediana_geom_centroid),
                    ],
                  ),
                ),
                content: const MedianaGeometricCentroid()),
            StickyHeader(
                header: Container(
                  color: AppColors.content(context),
                  child: Column(
                    children: [
                      const ImageInfoWidget(
                          patchAsset:
                              ConstAssetsImageRaster.equilateralTriangleSr),
                      TextTitleDetail(
                          text: TranslateHelper.bisection_inscribed_circle),
                    ],
                  ),
                ),
                content: const BisectionInscribedCircle()),
            StickyHeader(
                header: Container(
                  color: AppColors.content(context),
                  child: Column(
                    children:  [
                      const ImageInfoWidget(
                          patchAsset:
                              ConstAssetsImageRaster.equilateralTriangleSR),
                      TextTitleDetail(
                          text: TranslateHelper.circumscribed_circle),
                    ],
                  ),
                ),
                content: const CircumscribedCircle()),
          ],
        );
      },
    );
  }
}

class CircumscribedCircle extends StatelessWidget {
  const CircumscribedCircle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemDetail(
          isActive: false,
          leading: 'R',
          subtitle: TranslateHelper.radius_diameter_circumscribed_circle,
          title:
              'r ${c.Rcircum.value} / ⌀ ${AppUtilsNumber.getFormatNumber(c.Rd * 2, GlobalServ.to.precisionResult.value)}',
        ),
        ItemDetail(
          isActive: false,
          leading: 'X',
          subtitle: TranslateHelper.x_cord_SR,
          title: c.xR.value,
        ),
        ItemDetail(
          isActive: false,
          leading: 'Y',
          subtitle: TranslateHelper.y_cord_SR,
          title: c.yR.value,
        ),
      ],
    );
  }
}

class BisectionInscribedCircle extends StatelessWidget {
  const BisectionInscribedCircle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemDetail(
          isActive: false,
          leading: 'la',
 subtitle: '${TranslateHelper.bis_of_side} a',
          title: c.lA.value,
        ),
        ItemDetail(
          isActive: false,
          leading: 'r',
          subtitle: TranslateHelper.radius_diameter_inscribed_circle,
          title:
              'r ${c.rInscribed.value} / ⌀ ${AppUtilsNumber.getFormatNumber(c.rd * 2, GlobalServ.to.precisionResult.value)}',
        ),
        ItemDetail(
          isActive: false,
          leading: 'X',
          subtitle: TranslateHelper.x_cord_Sr,
          title: c.xr.value,
        ),
        ItemDetail(
          isActive: false,
          leading: 'Y',
          subtitle: TranslateHelper.y_cord_Sr,
          title: c.yr.value,
        ),
      ],
    );
  }
}

class MedianaGeometricCentroid extends StatelessWidget {
  const MedianaGeometricCentroid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemDetail(
          isActive: false,
          leading: 'ma',
         subtitle: '${TranslateHelper.med_of_side} a',
          title: c.mA.value,
        ),
        ItemDetail(
          isActive: false,
          leading: 'X',
          subtitle: TranslateHelper.x_cord_S,
          title: c.xSPoint.value,
        ),
        ItemDetail(
          isActive: false,
          leading: 'Y',
          subtitle: TranslateHelper.y_cord_S,
          title: c.ySPoint.value,
        ),
      ],
    );
  }
}

class EquilateralSidesAngles extends StatelessWidget {
  const EquilateralSidesAngles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // AppWidgets.dividerWelcome(),

        ItemDetail(
          isActive: c.isAvailableOneParam(EquilateralTriangle.aSide),
          leading: 'a',
          subtitle: 'a - ${TranslateHelper.sides_triangle}',
          title: c.aSide.value,
        ),

        ItemDetail(
          isActive: c.isAvailableOneParam(EquilateralTriangle.hHeight),
          leading: 'h',
          subtitle: TranslateHelper.h_height_triangle,
          title: c.hHeight.value,
        ),
      ],
    );
  }
}
