import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarTitle extends StatelessWidget {
  final String appTitle;

  const AppBarTitle({
    Key? key,
    required this.appTitle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      appTitle,
      style: TextStyle(
          fontFamily: AppThemes.sourceSans,
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
          letterSpacing: 0.5.w,
          height: 1.5.h,
          color: AppColors.kPrimaryColor),
    );
  }
}
