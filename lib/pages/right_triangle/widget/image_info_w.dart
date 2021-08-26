import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

import '../../../const.dart';
import 'a_angle_w.dart';
import 'a_cathet_w.dart';
import 'b_angle.dart';
import 'b_cathet_w.dart';
import 'c_hypotenusea_w.dart';

class ImageInfoWidget extends StatelessWidget {
  const ImageInfoWidget({
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
                image: AssetImage('assets/image/triangle/r_triangle_info.png'),
              ),
            ),
            //all widget text in image

            const TextInfo(angle: 0, posX: 0, posY: 42.345, text: 'a'),
            const TextInfo(angle: 0, posX: -42.845, posY: 0, text: 'b'),
            const TextInfo(angle: 0, posX: -42.845, posY: 0, text: 'b'),
            const TextInfo(angle: 0, posX: -18.225, posY: 18.225, text: 'h'),
            const TextInfo(angle: 0, posX: 10.98, posY: 25.9, text: 'α'),
            const TextInfo(angle: 0, posX: -24.329, posY: -7.188, text: 'β'),
            const TextInfo(angle: 0, posX: 8.4, posY: -8.4, text: 'c'),
            const TextInfo(angle: 0, posX: 22.42, posY: 14.03, text: 'm'),
            const TextInfo(angle: 0, posX: -14.03, posY: -22.42, text: 'k'),
          ],
        );
      }),
    );
  }
}

class TextInfo extends StatelessWidget {
  const TextInfo(
      {Key? key,
      required this.posX,
      required this.posY,
      required this.angle,
      required this.text})
      : super(key: key);

  final double posX;
  final double posY;
  final double angle;
  final String text;

  @override
  Widget build(BuildContext context) {
    double minSize = GetStorage().read(ConstGet.minSize);
    print('obx build text info image');
    return Transform.translate(
      offset: Offset((posX / 100) * minSize, (posY / 100) * minSize),
      child: Transform.rotate(
          angle: angle * pi / 180,
          child: Text(
            text,
            style: TextStyle(
              backgroundColor: ConstColors.scaffoldBackground,
              fontSize: 60.sp,
            ),
          )),
    );
  }
}
