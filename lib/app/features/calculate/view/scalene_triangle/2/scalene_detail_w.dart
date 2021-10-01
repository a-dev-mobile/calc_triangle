import 'package:calc_triangle/app/config/theme/app_color.dart';
import 'package:calc_triangle/app/config/theme/app_style.dart';
import 'package:calc_triangle/app/constants/const_assets.dart';
import 'package:calc_triangle/app/features/calculate/controllers/right_c.dart';
import 'package:calc_triangle/app/features/calculate/controllers/scalene_c.dart';
import 'package:calc_triangle/app/features/calculate/view/scalene_triangle/2/image_info_w.dart';
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
                  child: const ImageInfoWidget(
                      patchAsset: ConstImageRaster.scaleneTriangleInfo),
                ),
                content: Column(
                  children: [
                    // AppWidgets.dividerWelcome(),
                    const TextTitleDetail(text: 'Sides and angles'),
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

                    const TextTitleDetail(text: 'Area and Perimeter'),
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
                )),
            StickyHeader(
                header: Container(
                  color: AppColors.content(context),
                  child: const ImageInfoWidget(
                    patchAsset: ConstImageRaster.scaleneTriangleS,
                  ),
                ),
                content: Column(
                  children: [
                    // AppWidgets.dividerWelcome(),
                    const TextTitleDetail(text: 'Sides and angles'),
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

                    const TextTitleDetail(text: 'Area and Perimeter'),
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
                )),


            StickyHeader(
                header: Container(
                  color: AppColors.content(context),
                  child: const ImageInfoWidget(
                      patchAsset: ConstImageRaster.scaleneTriangleSr),
                ),
                content: Column(
                  children: [
                    // AppWidgets.dividerWelcome(),
                    const TextTitleDetail(text: 'Sides and angles'),
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

                    const TextTitleDetail(text: 'Area and Perimeter'),
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
                )),

                     StickyHeader(
                header: Container(
                  color: AppColors.content(context),
                  child: const ImageInfoWidget(
                      patchAsset: ConstImageRaster.scaleneTriangleSR),
                ),
                content: Column(
                  children: [
                    // AppWidgets.dividerWelcome(),
                    const TextTitleDetail(text: 'Sides and angles'),
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

                    const TextTitleDetail(text: 'Area and Perimeter'),
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
                )), ],
        );
      },
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
