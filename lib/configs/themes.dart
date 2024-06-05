import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

class AppThemes {
  final BuildContext context;

  AppThemes(this.context);

  //font name
  static const String sourceSans = "SourceSans";
  static const String dmSerifDisplay = "DMSerifDisplay";
  static const String italianno = "Italianno";
  static const String jaldi = "Jaldi";
  static const String specialElite = "SpecialElite";
  static const String spicyRice = "SpicyRice";
  static const String spectral = "Spectral";
  static const String spirax = "Spirax";

  //region styles
  TextStyle lightText = TextStyle(
    fontWeight: FontWeight.w300,
    fontStyle: FontStyle.normal,
    fontFamily: sourceSans,
    color: Colors.white.withOpacity(0.87),
    letterSpacing: 0.5.w,
    fontSize: 24.sp,
    height: 1.2.h,
  );

  TextStyle normalText = TextStyle(
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontFamily: sourceSans,
    color: Colors.white.withOpacity(0.87),
    letterSpacing: 0.5.w,
    fontSize: 13.sp,
  );

  TextStyle boldText = TextStyle(
    color: Colors.white.withOpacity(0.87),
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontFamily: sourceSans,
    fontSize: 20.sp,
    letterSpacing: 0.5.w,
  );

  BoxDecoration lineWidth = BoxDecoration(
      border: Border.all(
    width: 1.w,
    color: AppColors.hPrimaryColor,
  ));
//endregion
}
