

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

late var c =EquilateralTriangleController.to;

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
                  children:[
                    const ImageInfoWidget(
                        patchAsset: ConstAssetsImageRaster.equilateralTriangleInfo),
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
                  children: const [
                    ImageInfoWidget(
                        patchAsset: ConstAssetsImageRaster.rightTriangleAP),
                    TextTitleDetail(text: 'Area and Perimeter'),
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
                    children: const [
                      ImageInfoWidget(
                          patchAsset: ConstAssetsImageRaster.rightTriangleS),
                      TextTitleDetail(text: 'Mediana and geometric centroid'),
                    ],
                  ),
                ),
                content: const MedianaGeometricCentroid()),
            StickyHeader(
                header: Container(
                  color: AppColors.content(context),
                  child: Column(
                    children: const [
                      ImageInfoWidget(
                          patchAsset: ConstAssetsImageRaster.rightTriangleSr),
                      TextTitleDetail(text: 'Bisection and inscribed circle'),
                    ],
                  ),
                ),
                content: const BisectionInscribedCircle()),
            StickyHeader(
                header: Container(
                  color: AppColors.content(context),
                  child: Column(
                    children: const [
                      ImageInfoWidget(
                          patchAsset: ConstAssetsImageRaster.rightTriangleSR),
                      TextTitleDetail(text: 'Circumscribed circle'),
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
          subtitle: 'Radius / diameter of the circumscribed circle ',
         title: 'r${c.R.value} / ⌀${AppUtilsNumber.getFormatNumber(c.Rd*2, GlobalServ.to.precisionResult.value)}',
        ),

 


        ItemDetail(
          isActive: false,
          leading: 'X',
          subtitle: 'X cordinate of the SR point',
          title: c.xR.value,
        ),
        ItemDetail(
          isActive: false,
          leading: 'Y',
          subtitle: 'Y cordinate of the SR point',
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
          subtitle: 'Bisection of side a',
          title: c.lA.value,
        ),
        ItemDetail(
          isActive: false,
          leading: 'lb',
          subtitle: 'Bisection of side b',
          title: c.lB.value,
        ), 
        ItemDetail(
          isActive: false,
          leading: 'lc',
          subtitle: 'Bisection of side c',
          title: c.lC.value,
        ),
        ItemDetail(
          isActive: false,
          leading: 'r',
          subtitle: 'Radius / diameter of the inscribed circle',
          title: 'r${c.r.value} / ⌀${AppUtilsNumber.getFormatNumber(c.rd*2, GlobalServ.to.precisionResult.value)}',
        ),
        ItemDetail(
          isActive: false,
          leading: 'X',
          subtitle: 'X cordinate of the Sr point',
          title: c.xr.value,
        ),
        ItemDetail(
          isActive: false,
          leading: 'Y',
          subtitle: 'Y cordinate of the Sr point',
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
          subtitle: 'Mediana of side a',
          title: c.mA.value,
        ),
        ItemDetail(
          isActive: false,
          leading: 'mb',
          subtitle: 'Mediana of side b',
          title: c.mB.value,
        ),
        ItemDetail(
          isActive: false,
          leading: 'mc',
          subtitle: 'Mediana of side c',
          title: c.mC.value,
        ),
        ItemDetail(
          isActive: false,
          leading: 'X',
          subtitle: 'X cordinate of the S point',
          title: c.xSPoint.value,
        ),
        ItemDetail(
          isActive: false,
          leading: 'Y',
          subtitle: 'Y cordinate of the S point',
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
            subtitle: 'a - catheti',
            title: c.aSide.value,
          ),
         
          ItemDetail(
            isActive: c.isAvailableOneParam(EquilateralTriangle.hHeight),
            leading: 'h',
            subtitle: 'h - height of the triangle',
            title: c.hHeight.value,
          ),
        
      ],
    );
  }
}














