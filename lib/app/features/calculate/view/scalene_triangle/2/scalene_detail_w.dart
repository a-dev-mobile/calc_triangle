import 'package:calc_triangle/app/config/theme/app_color.dart';
import 'package:calc_triangle/app/config/theme/app_style.dart';
import 'package:calc_triangle/app/constants/const_assets.dart';
import 'package:calc_triangle/app/features/calculate/controllers/right_c.dart';
import 'package:calc_triangle/app/features/calculate/controllers/scalene_c.dart';
import 'package:calc_triangle/app/shared_components/detail_info/area_perim.dart';
import 'package:calc_triangle/app/shared_components/image_info_w.dart';
import 'package:calc_triangle/app/shared_components/app_widgets.dart';
import 'package:calc_triangle/app/shared_components/detail_info/detail_item.dart';
import 'package:calc_triangle/app/shared_components/detail_info/detail_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sticky_headers/sticky_headers.dart';

late var c = ScaleneTriangleController.to;

class ScaleneDetail extends StatelessWidget {
  const ScaleneDetail({Key? key}) : super(key: key);

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
                  children: const [
                    ImageInfoWidget(
                        patchAsset: ConstAssetsImageRaster.scaleneTriangleInfo),
                    TextTitleDetail(text: 'Sides, height and angles'),
                  ],
                ),
              ),
              content: const ScaleneSidesAngles(),
            ),
            StickyHeader(
              header: Container(
                color: AppColors.content(context),
                child: Column(
                  children: const [
                    ImageInfoWidget(
                        patchAsset: ConstAssetsImageRaster.scaleneTriangleAP),
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
                          patchAsset: ConstAssetsImageRaster.scaleneTriangleS),
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
                          patchAsset: ConstAssetsImageRaster.scaleneTriangleSr),
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
                          patchAsset: ConstAssetsImageRaster.scaleneTriangleSR),
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
          subtitle: 'Radius of the circumscribed circle ',
          title: c.R.value,
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
          subtitle: 'Radius of the inscribed circle',
          title: c.r.value,
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

class ScaleneSidesAngles extends StatelessWidget {
  const ScaleneSidesAngles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // AppWidgets.dividerWelcome(),

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
          title: c.yAngle.value,
        ),
      ],
    );
  }
}







//     return SingleChildScrollView(child: Obx(() {
//       return Column(
//         children: [
//           const ScaleneTriangleImageInfoWidget(),
//           // AppWidgets.dividerWelcome(),
//           const TextTitleDetail(text: 'Sides and angles'),
//           ItemDetail(
//             isActive: c.isAvailableOneParam(ScaleneTriangle.aSide),
//             leading: 'a',
//             subtitle: 'a - base of the triangle',
//             title: c.aSide.value,
//           ),
//           ItemDetail(
//             isActive: c.isAvailableOneParam(ScaleneTriangle.bSide),
//             leading: 'b',
//             subtitle: 'b - sides of the triangle',
//             title: c.bSide.value,
//           ),
//           ItemDetail(
//             isActive: c.isAvailableOneParam(ScaleneTriangle.cSide),
//             leading: 'c',
//             subtitle: 'c - sides of the triangle',
//             title: c.cSide.value,
//           ),
//           ItemDetail(
//             isActive: c.isAvailableOneParam(ScaleneTriangle.hHeight),
//             leading: 'h',
//             subtitle: 'h - height of the triangle',
//             title: c.hHeight.value,
//           ),
//           ItemDetail(
//             isActive: c.isAvailableOneParam(ScaleneTriangle.aAngle),
//             leading: 'α',
//             subtitle: 'α - internal angle in degrees',
//             title: c.aAngle.value,
//           ),
//           ItemDetail(
//             isActive: c.isAvailableOneParam(ScaleneTriangle.bAngle),
//             leading: 'β',
//             subtitle: 'β - internal angle in degrees',
//             title: c.bAngle.value,
//           ),
//           ItemDetail(
//             isActive: c.isAvailableOneParam(ScaleneTriangle.yAngle),
//             leading: 'γ',
//             subtitle: 'γ - internal angle in degrees',
//             title: c.aAngle.value,
//           ),

//           const TextTitleDetail(text: 'Area and Perimeter'),
//           ItemDetail(
//             isActive: false,
//             leading: 'A',
//             subtitle: 'Area',
//             title: c.area.value,
//           ),
//           ItemDetail(
//             isActive: false,
//             leading: 'P',
//             subtitle: 'Perimeter',
//             title: c.perimeter.value,
//           ),

//           const TextTitleDetail(text: 'Geometric centroid'),
//           ItemDetail(
//             isActive: false,
//             leading: 'Xs',
//             subtitle: 'X cordinate of the S point',
//             title: c.xSPoint.value,
//           ),
//           ItemDetail(
//             isActive: false,
//             leading: 'Ys',
//             subtitle: 'Y cordinate of the S point',
//             title: c.ySPoint.value,
//           ),
//         ],
//       );
//     }));
//   }
// }
