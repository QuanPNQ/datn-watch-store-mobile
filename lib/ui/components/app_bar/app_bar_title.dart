import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';

class AppBarTitle extends StatelessWidget {
  final String appTitle;
  final String fontName;
  final double? fontSize;
  final bool isShowBackButton;
  final Function()? onPop;

  const AppBarTitle(
      {Key? key,
      required this.appTitle,
      this.fontName = AppThemes.specialElite,
      this.fontSize,
      this.isShowBackButton = true,
      this.onPop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42),
          child: TextNormal(
            title: appTitle,
            colors: AppColors.bPrimaryColor,
            fontName: fontName,
            size: fontSize,
            maxLine: 1,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: onPop ?? () => Navigator.pop(context),
                child: SizedBox(
                    width: 32,
                    height: 32,
                    child: isShowBackButton
                        ? Icon(
                            Icons.arrow_back_ios_new,
                            size: 24,
                          )
                        : null)),
          ],
        )
      ],
    );
  }
}
