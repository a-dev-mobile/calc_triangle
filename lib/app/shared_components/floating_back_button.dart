
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config/theme/app_color.dart';

class FloatingBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  
  const FloatingBackButton({
    super.key,
    this.onPressed,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10.h,
      left: 10.w,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onPressed ?? () => Get.back(),
          child: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: backgroundColor ?? AppColors.content(context).withOpacity(0.7),
              shape: BoxShape.circle,
            ),
            child: Platform.isIOS 
                ? Icon(
                    CupertinoIcons.back,
                    color: iconColor ?? AppColors.contentRevers(context),
                    size: 22.sp,
                  )
                : Icon(
                    Icons.arrow_back,
                    color: iconColor ?? AppColors.contentRevers(context),
                    size: 22.sp,
                  ),
          ),
        ),
      ),
    );
  }
}