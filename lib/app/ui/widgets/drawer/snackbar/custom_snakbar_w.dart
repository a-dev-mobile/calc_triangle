import 'package:calc_triangle/app/constant/const_color.dart';
import 'package:calc_triangle/app/ui/theme/app_color.dart';
import 'package:calc_triangle/app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSnackBar extends StatelessWidget {
  const CustomSnackBar({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppUtils.getWidth(context),
      // color: AppColors.contentRevers(context).withOpacity(0.5),
      child: Column(
        children: [
          Align(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  Icon(Icons.info_outline,color: ConstColor.warninng,),
                  SizedBox(width: 2.w,),
                  
                  Text(
                    message,
                    style: TextStyle(fontSize: 15.sp, color: AppColors.text(context)),
                  ),
                ],
              )),
       Divider()
       
        ],
      ),
      height: AppUtils.getHeight(context) * 0.05,
    );
  }
}
