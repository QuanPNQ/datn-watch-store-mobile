import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class InputFiled extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final  FormFieldSetter<String>? onSaved;

  const InputFiled({Key? key, required this.hintText, required this.controller, this.validator, this.onSaved}) : super(key: key);

  @override
  _InputFiledState createState() => _InputFiledState();
}

class _InputFiledState extends State<InputFiled> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:  TextDirection.rtl,                //
      child: TextFormField(
        textDirection: TextDirection.ltr,             //
        keyboardType: TextInputType.emailAddress,
        controller: widget.controller,
        autofocus: false,
        validator: widget.validator,
        onSaved: widget.onSaved,
        cursorColor: AppColors.jPrimaryColor,
        onChanged: (value){
          setState(() {

          });
        },
        style:  TextStyle(
            fontFamily: 'ProximaNovaA',
            color: AppColors.kPrimaryColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5),
        decoration: InputDecoration(
          hintTextDirection: TextDirection.ltr,               //
          errorStyle: TextStyle(
              fontSize: 14.sp,
              color: AppColors.pink,
              fontFamily: 'ProximaNovaA',fontWeight: FontWeight.normal,letterSpacing: 0.5.r),
          filled: true,
          fillColor: AppColors.hPrimaryColor,
          contentPadding:
             EdgeInsets.only(left: 16.w, top: 25.h, bottom: 16.h),
          hintText: widget.hintText,
          hintStyle:  TextStyle(
              color: AppColors.hintTextPrimaryColor,
              fontSize: 16.sp),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r, ),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.jPrimaryColor),
              borderRadius: BorderRadius.circular(12.r,)
          ),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.pink),
              borderRadius: BorderRadius.circular(12.r,)
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide:  BorderSide(
              color: widget.controller.text==""?AppColors.lPrimaryColor:AppColors.oPrimaryColor,
              width: 0.5.w,
            ),
          ),

        ),
      ),
    );
  }
}
