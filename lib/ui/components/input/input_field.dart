import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputField extends StatefulWidget {
  final String? labelText;
  final double? labelSize;
  final Color? labelColor;
  final Color? fillColor;
  final String? hintText;
  final int? maxLines;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final bool isReadOnly;
  final bool isObscureText;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters;
  final InputBorder? border;
  final Function(String value)? onChange;
  final EdgeInsetsGeometry? contentPadding;

  const InputField(
      {Key? key,
      this.hintText,
      this.fillColor,
      this.contentPadding,
      this.onChange,
      this.maxLines,
      this.border,
      this.labelText,
      this.labelSize = 20,
      this.labelColor = AppColors.bPrimaryColor,
      required this.controller,
      this.validator,
      this.onSaved,
      this.isReadOnly = false,
      this.isObscureText = false,
      this.inputType,
      this.inputFormatters})
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
        TextFormField(
          obscureText: widget.isObscureText,
          textDirection: TextDirection.ltr,
          keyboardType: widget.inputType ?? TextInputType.text,
          controller: widget.controller,
          autofocus: false,
          validator: widget.validator,
          onSaved: widget.onSaved,
          cursorColor: AppColors.bPrimaryColor,
          textAlignVertical: TextAlignVertical.center,
          readOnly: widget.isReadOnly,
          inputFormatters: widget.inputFormatters,
          maxLines: widget.isObscureText ? 1 : widget.maxLines,
          onChanged: widget.onChange ??
              (value) {
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
            contentPadding:
                widget.contentPadding ?? EdgeInsets.only(left: 12, right: 12),
            hintTextDirection: TextDirection.ltr,
            errorStyle: TextStyle(
                fontSize: 14,
                color: AppColors.pink,
                fontFamily: AppThemes.jaldi,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.5.r,
                height: 1),
            filled: true,
            fillColor: widget.fillColor ?? AppColors.grey1.withOpacity(0.74),
            hintText: widget.hintText,
            hintStyle: TextStyle(
                color: AppColors.bPrimaryColor.withOpacity(0.3),
                fontSize: 14,
                fontFamily: AppThemes.jaldi,
                height: 1),
            border: widget.border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }
}
