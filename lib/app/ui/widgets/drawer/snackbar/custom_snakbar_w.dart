import 'package:calc_triangle/app/ui/theme/app_color.dart';
import 'package:calc_triangle/app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSnackBar extends StatelessWidget {
  const CustomSnackBar({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppUtils.getWidth(context),
      color: AppColors.contentRevers(context).withOpacity(0.5),
      child: Align(
          alignment: Alignment.center,
          child: Text(
            message,
            style: TextStyle(fontSize: 15.sp, color: AppColors.text(context)),
          )),
      height: AppUtils.getHeight(context) * 0.05,
    );
  }
}
