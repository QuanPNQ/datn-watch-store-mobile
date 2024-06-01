import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailInputFiled extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final bool? enable;
  final ValueChanged<String>? onChanged;
  final bool? isValid;

  const EmailInputFiled(
      {Key? key,
      this.onChanged,
      required this.hintText,
      required this.controller,
      this.validator,
      this.onSaved,
      this.enable,
      this.isValid})
      : super(key: key);

  @override
  _EmailInputFiledState createState() => _EmailInputFiledState();
}

class _EmailInputFiledState extends State<EmailInputFiled> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        enabled: widget.enable ?? true,
        textDirection: TextDirection.ltr,
        keyboardType: TextInputType.emailAddress,
        controller: widget.controller,
        autofocus: false,
        onChanged: widget.onChanged,
        validator: widget.validator,
        onSaved: widget.onSaved,
        cursorColor: AppColors.heroRed,
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
          hintText: widget.hintText,
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
              color: widget.isValid == false
                  ? AppColors.heroRed
                  : AppColors.grey800,
              width: 1.w,
            ),
          ),
        ),
      ),
    );
  }
}
