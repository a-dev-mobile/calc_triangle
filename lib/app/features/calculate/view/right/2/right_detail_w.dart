import 'package:calc_triangle/app/config/theme/app_color.dart';
import 'package:calc_triangle/app/constants/const_assets.dart';
import 'package:calc_triangle/app/features/calculate/controllers/right_c.dart';
import 'package:calc_triangle/app/services/global_serv.dart';
import 'package:calc_triangle/app/shared_components/detail_info/area_perim.dart';
import 'package:calc_triangle/app/shared_components/detail_info/detail_item.dart';
import 'package:calc_triangle/app/shared_components/detail_info/detail_title.dart';
import 'package:calc_triangle/app/shared_components/image_info_w.dart';
import 'package:calc_triangle/app/translations/translate_helper.dart';
import 'package:calc_triangle/app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

var c = RightTriangleController.to;

class RightDetail extends StatelessWidget {
  const RightDetail({Key? key}) : super(key: key);

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
                        patchAsset: ConstAssetsImageRaster.rightTriangleInfo),
                    TextTitleDetail(text: TranslateHelper.sides_height_angles),
                  ],
                ),
              ),
              content: const RightSidesAngles(),
            ),
            StickyHeader(
              header: Container(
                color: AppColors.content(context),
                child: Column(
                  children: [
                    const ImageInfoWidget(
                        patchAsset: ConstAssetsImageRaster.rightTriangleAP),
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
                          patchAsset: ConstAssetsImageRaster.rightTriangleS),
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
                          patchAsset: ConstAssetsImageRaster.rightTriangleSr),
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
                    children: [
                      const ImageInfoWidget(
                          patchAsset: ConstAssetsImageRaster.rightTriangleSR),
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
          leading: 'lb',
          subtitle: '${TranslateHelper.bis_of_side} b',
          title: c.lB.value,
        ),
        ItemDetail(
          isActive: false,
          leading: 'lc',
          subtitle: '${TranslateHelper.bis_of_side} c',
          title: c.lC.value,
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
          leading: 'mb',
          subtitle: '${TranslateHelper.med_of_side} b',
          title: c.mB.value,
        ),
        ItemDetail(
          isActive: false,
          leading: 'mc',
          subtitle: '${TranslateHelper.med_of_side} c',
          title: c.mC.value,
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

class RightSidesAngles extends StatelessWidget {
  const RightSidesAngles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // AppWidgets.dividerWelcome(),

        ItemDetail(
          isActive: c.isAvailableOneParam(RightTriangle.aSide),
          leading: 'a',
          subtitle: 'a - ${TranslateHelper.catheti}',
          title: c.aSide.value,
        ),
        ItemDetail(
          isActive: c.isAvailableOneParam(RightTriangle.bSide),
          leading: 'b',
          subtitle: 'b - ${TranslateHelper.catheti}',
          title: c.bSide.value,
        ),
        ItemDetail(
          isActive: c.isAvailableOneParam(RightTriangle.cSide),
          leading: 'c',
          subtitle: TranslateHelper.c_hypotenuse,
          title: c.cSide.value,
        ),
        ItemDetail(
          isActive: c.isAvailableOneParam(RightTriangle.hHeight),
          leading: 'h',
          subtitle: TranslateHelper.h_height_triangle,
          title: c.hHeight.value,
        ),
        ItemDetail(
          isActive: c.isAvailableOneParam(RightTriangle.aAngle),
          leading: 'α',
          subtitle: 'α - ${TranslateHelper.acute_angles_degrees}',
          title: c.aAngle.value,
        ),
        ItemDetail(
          isActive: c.isAvailableOneParam(RightTriangle.bAngle),
          leading: 'β',
          subtitle: 'β - ${TranslateHelper.acute_angles_degrees}',
          title: c.bAngle.value,
        ),
        ItemDetail(
          isActive: c.isAvailableOneParam(RightTriangle.mCompCside),
          leading: 'm',
          subtitle: 'm - ${TranslateHelper.component} с',
          title: c.mCompCside.value,
        ),
        ItemDetail(
          isActive: c.isAvailableOneParam(RightTriangle.kCompCside),
          leading: 'k',
          subtitle: 'k - ${TranslateHelper.component} с',
          title: c.kCompCside.value,
        ),
      ],
    );
  }
}
