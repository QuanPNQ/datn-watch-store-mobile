import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputField extends StatefulWidget {
  final String? labelText;
  final double? labelSize;
  final Color? labelColor;
  final String? hintText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;

  const InputField(
      {Key? key,
      this.hintText,
      this.labelText,
      this.labelSize = 20,
      this.labelColor = AppColors.bPrimaryColor,
      required this.controller,
      this.validator,
      this.onSaved})
      : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: TextNormal(
              title: widget.labelText!,
              colors: widget.labelColor,
              fontName: AppThemes.jaldi,
              size: widget.labelSize,
            ),
          ),
        SizedBox(
          height: 45,
          child: TextFormField(
            textDirection: TextDirection.ltr,
            keyboardType: TextInputType.text,
            controller: widget.controller,
            autofocus: false,
            validator: widget.validator,
            onSaved: widget.onSaved,
            cursorColor: AppColors.bPrimaryColor,
            textAlignVertical: TextAlignVertical.center,
            onChanged: (value) {
              setState(() {});
            },
            style: TextStyle(
                fontFamily: AppThemes.jaldi,
                color: AppColors.bPrimaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                height: 1,
                letterSpacing: 0.5),
            decoration: InputDecoration(
              hintTextDirection: TextDirection.ltr,
              errorStyle: TextStyle(
                  fontSize: 14,
                  color: AppColors.pink,
                  fontFamily: AppThemes.jaldi,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.5.r),
              filled: true,
              fillColor: AppColors.grey1.withOpacity(0.74),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                  color: AppColors.bPrimaryColor.withOpacity(0.3),
                  fontSize: 14,
                  fontFamily: AppThemes.jaldi,
                  height: 1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  10,
                ),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(
                    10,
                  )),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.pink),
                  borderRadius: BorderRadius.circular(
                    10,
                  )),
              // enabledBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(10),
              //   borderSide: BorderSide(
              //     color: widget.controller.text == ""
              //         ? AppColors.lPrimaryColor
              //         : AppColors.oPrimaryColor,
              //     width: 0.5.w,
              //   ),
              // ),
            ),
          ),
        ),
      ],
    );
  }
}
