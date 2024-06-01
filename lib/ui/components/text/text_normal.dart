import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextNormal extends StatelessWidget {
  final String title;
  final double? size;
  final Color? colors;
  final double? lineHeight;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final String fontName;

  const TextNormal(
      {Key? key,
      required this.title,
      this.size,
      this.colors,
      this.fontStyle,
      this.fontName = AppThemes.sourceSans,
      this.lineHeight = 1,
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
      maxLines: 99,
      style: TextStyle(
          color: colors ?? AppColors.kPrimaryColor,
          fontWeight: fontWeight ?? FontWeight.w400,
          fontStyle: fontStyle ?? FontStyle.normal,
          fontFamily: fontName,
          height: lineHeight,
          fontSize: size ?? 16,
          letterSpacing: 0.5.w),
    );
  }
}
