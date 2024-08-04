import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';

class ButtonNormal extends StatelessWidget {
  const ButtonNormal(
      {Key? key,
      required this.text,
      this.textColor = AppColors.black1,
      this.fontName = AppThemes.sourceSans,
      this.fontWeight = FontWeight.w400,
      this.fontSize = 16.0,
      this.textStyle,
      this.onPressed,
      this.defaultColor = AppColors.dPrimaryColor,
      this.backgroundColor = AppColors.yellow1,
      this.borderColor = Colors.transparent,
      this.padding = const EdgeInsets.all(0),
      this.borderWidth = 1.0,
      this.radius = 20,
      this.height = 50,
      this.width,
      this.lineHeight,
      this.enabled = true,
      this.isShadow = false,
      this.alignmentGeometry})
      : super(key: key);

  /// Text Button
  final String text;

  /// Text Color
  final Color textColor;

  /// Font Name
  final String fontName;

  /// Font Name
  final double fontSize;

  /// Font Weight
  final FontWeight fontWeight;

  /// Style Text Button
  final TextStyle? textStyle;

  /// Button Event Tap
  final ValueGetter<void>? onPressed;

  /// Button default color
  final Color defaultColor;

  /// Button background
  final Color backgroundColor;

  /// Border Button
  final Color borderColor;

  /// Border Width
  final double borderWidth;

  /// Padding
  final EdgeInsetsGeometry padding;

  /// Border Radius
  final double radius;

  /// Button height
  final double height;

  /// Button width
  final double? width;

  final bool enabled;

  final bool isShadow;

  /// Alignment
  final AlignmentGeometry? alignmentGeometry;

  /// Line height
  final double? lineHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding,
        alignment: alignmentGeometry ?? Alignment.center,
        child: SizedBox(
            width: width ?? double.infinity,
            height: height,
            child: ElevatedButton(
                onPressed: enabled ? onPressed : null,
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        enabled ? backgroundColor : defaultColor),
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(radius),
                            side: BorderSide(
                                color: borderColor, width: borderWidth))),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    elevation: MaterialStateProperty.resolveWith<double>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed) ||
                            states.contains(MaterialState.disabled)) {
                          return 0;
                        }
                        return isShadow ? 10 : 0;
                      },
                    )),
                child: TextNormal(
                  title: text,
                  fontName: fontName,
                  lineHeight: lineHeight,
                  fontWeight: fontWeight,
                  size: fontSize,
                  colors: textColor,
                ))));
  }
}
