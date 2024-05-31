import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextNormal extends StatelessWidget {
  final String title;
  final double size;
  final Color colors;
  final double lineHeight;
  final FontWeight? fontWeight;

  const TextNormal(
      {Key? key,
      required this.title,
      required this.size,
      required this.colors,
      required this.lineHeight,
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
          color: colors,
          fontWeight: fontWeight ?? FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontFamily: 'SpaceGrotesk',
          height: lineHeight,
          fontSize: size,
          letterSpacing: 0.5.w),
    );
  }
}
