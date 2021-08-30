import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

import '../../../constants.dart';
import 'a_angle_w.dart';
import 'a_cathet_w.dart';
import 'b_angle.dart';
import 'b_cathet_w.dart';
import 'c_hypotenusea_w.dart';

class ImageInputWidget extends StatelessWidget {
  const ImageInputWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.4.sh,
      width: 1.sw,
      child: LayoutBuilder(builder: (context, constraints) {
        var minSize = min(constraints.maxWidth, constraints.maxHeight);
        GetStorage().write(ConstGet.minSize, minSize);

        return Stack(
          alignment: Alignment.center,

          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const SizedBox.expand(
              child: Image(
                fit: BoxFit.contain,
                color: kColorImage,
                image: AssetImage('assets/image/triangle/r_triangle_input.png'),
              ),
            ),
            //all widget text in image

            const AcathetWidget(angle: 0, posX: 0, posY: 42.345),
            const BcathetWidget(angle: -90, posX: -42.845, posY: 0),
            const AangleWidget(angle: -67.66, posX: -5.396, posY: 19.117),
            const BangleWidget(angle: -22.96, posX: -18.073, posY: 7.915),
            const ChypotenuseWidget(angle: 45, posX: 4.166, posY: -4.166),
            const Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Icon(
                Icons.update,
                color: kPrimaryColor,
              ),
            )
          ],
        );
      }),
    );
  }
}
