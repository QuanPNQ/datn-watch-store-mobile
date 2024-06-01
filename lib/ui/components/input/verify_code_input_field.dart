import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifyCodeInputField extends StatefulWidget {
  final TextEditingController controller;

  const VerifyCodeInputField({Key? key, required this.controller})
      : super(key: key);

  @override
  _VerifyCodeInputState createState() => _VerifyCodeInputState();
}

class _VerifyCodeInputState extends State<VerifyCodeInputField> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        textDirection: TextDirection.ltr,
        controller: widget.controller,
        autofocus: false,
        cursorColor: AppColors.gray700,
        style: TextStyle(
            fontFamily: AppThemes.sourceSans,
            color: AppColors.whiteHightEmphasis,
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.5),
        decoration: InputDecoration(
          hintTextDirection: TextDirection.ltr,
          errorStyle: TextStyle(
              fontSize: 14.sp,
              color: AppColors.pink,
              height: 1.h,
              fontFamily: AppThemes.sourceSans,
              fontWeight: FontWeight.normal,
              letterSpacing: 0.5.w),
          filled: true,
          fillColor: AppColors.gray900,
          contentPadding:
              EdgeInsets.only(left: 16.w, top: 16.h, bottom: 16.h, right: 16.w),
          hintStyle:
              TextStyle(color: AppColors.hintTextPrimaryColor, fontSize: 16.sp),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              12.r,
            ),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.gray700,
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(
                12.r,
              )),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: AppColors.grey800,
              width: 1.w,
            ),
          ),
        ),
      ),
    );
  }
}
