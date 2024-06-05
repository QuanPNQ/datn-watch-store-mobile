import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';

class AppBarTitle extends StatelessWidget {
  final String appTitle;
  final bool isShowBackButton;

  const AppBarTitle(
      {Key? key, required this.appTitle, this.isShowBackButton = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        TextNormal(
          title: appTitle,
          colors: AppColors.bPrimaryColor,
          fontName: AppThemes.specialElite,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () => Navigator.pop(context),
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
