// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var w = size.width;
    var h = size.height;
    print('w $w h $h');

    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        height: 1.sw,
        width: 1.sw,
        child: LayoutBuilder(builder: (context, constraints) {
          var wStack = constraints.maxWidth;
          var hStack = constraints.maxHeight;
          var minSize = min(wStack, hStack);
          print('wStack $wStack hStack $hStack');

          return Stack(
            alignment: Alignment.center,
            children: [
              SizedBox.expand(
                child: Container(
                    color: Colors.black38,
                    child: Image(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/image/triangle/4_3.png'),
                    )),
              ),
              Transform.translate(
                  offset: Offset(-0.15 * minSize, 0),
                  child: Text(
                    '621.123',
                    style: TextStyle(fontSize: 60.sp),
                  )),
              Transform.translate(
                  offset: Offset(-0.08 * minSize, 0.22 * minSize),
                  child: TextButton(
                    onPressed: () {},
                    child: Text('asd'),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.white, width: 3)))),
                  )),
              Transform.translate(
                  offset: Offset(-0.38 * minSize, -0.03 * minSize),
                  child: Transform.rotate(
                    angle: -90 * pi / 180,
                    child: InkWell(
                      onTap: () {
                        print('object');
                      },
                      child: Text(
                        '100.45123',
                        style: TextStyle(fontSize: 60.sp),
                      ),
                    ),
                  )),
            ],
          );
        }),
      ),
    ));
  }
}




//     return Scaffold(
//         body: SafeArea(
//       child: Container(
//         width: 640.w,
//         height: 800.h,
//         color: Colors.blue,
//         child: Stack(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                   color: Colors.green,
//                   image: DecorationImage(
//                     image: ExactAssetImage('assets/image/triangle/4.webp'),
//                     fit: BoxFit.contain,
//                   )),
//             ),
//             Positioned(
//               child: Text(
//                 'click',
//                 style: TextStyle(fontSize: 100.sp),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
// }
