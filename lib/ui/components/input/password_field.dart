import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mob/configs/images.dart';

class PasswordFiled extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final bool? enable;
  final ValueChanged<String>? onChanged;
  final bool? isValid;

  const PasswordFiled(
      {Key? key,
      required this.hintText,
      required this.controller,
      this.validator,
      this.onSaved,
      this.enable,
      this.onChanged,
      this.isValid})
      : super(key: key);

  @override
  _PasswordFiledState createState() => _PasswordFiledState();
}

class _PasswordFiledState extends State<PasswordFiled> {
  bool _passwordVisible = true;

  @override
  void initState() {
    super.initState();
  }

  late FocusNode focusNode = FocusNode()
    ..addListener(() {
      setState(() {});
    });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr, //
      child: TextFormField(
        focusNode: focusNode,
        enabled: widget.enable ?? true,
        obscureText: widget.enable == false ? true : _passwordVisible,
        autofocus: false,
        controller: widget.controller,
        validator: widget.validator,
        onChanged: widget.onChanged,
        onSaved: widget.onSaved,
        cursorColor: AppColors.heroRed,
        style: TextStyle(
            fontFamily: AppThemes.sourceSans,
            color: AppColors.whiteHightEmphasis,
            fontSize: 16.sp,
            fontWeight: _passwordVisible ? FontWeight.bold : FontWeight.w400,
            letterSpacing: 0.5.w),
        decoration: InputDecoration(
          hintTextDirection: TextDirection.ltr,
          filled: true,
          fillColor: AppColors.gray900,
          errorStyle: TextStyle(
              fontSize: 14.sp,
              color: AppColors.pink,
              height: 1.h,
              fontFamily: AppThemes.sourceSans,
              fontWeight: FontWeight.normal,
              letterSpacing: 0.5.w),
          contentPadding: EdgeInsets.only(left: 16.w, top: 16.h, bottom: 16.w),
          hintText: widget.hintText,
          hintStyle: TextStyle(
              color: AppColors.gray600,
              fontSize: 16.sp,
              fontWeight: FontWeight.w300),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
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
          suffixIcon: LayoutBuilder(builder: (context, constraint) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: constraint.minHeight / 3),
                child: SvgPicture.asset(
                  _passwordVisible ? AppImages.iconHide : AppImages.iconShow,
                  fit: BoxFit.contain,
                  color: focusNode.hasFocus
                      ? AppColors.whiteHightEmphasis
                      : AppColors.gray600,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
