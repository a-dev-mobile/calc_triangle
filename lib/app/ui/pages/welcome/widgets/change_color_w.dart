import 'package:calc_triangle/app/ui/theme/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeColorWidget extends StatelessWidget {
  const ChangeColorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        const Text(
          ' Select the color of theme ',
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleButton(
              onTap: () {},
            ),
            CircleButton(
              onTap: () {},
            ),
            CircleButton(
              onTap: () {},
            ),
            CircleButton(
              onTap: () {},
            ),
            CircleButton(
              onTap: () {},
            ),
            CircleButton(
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class CircleButton extends StatelessWidget {
  const CircleButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Container(
        width: 50.r,
        height: 50.r,
        decoration:
            const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
      ),
    );
  }
}
