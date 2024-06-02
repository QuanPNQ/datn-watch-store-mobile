import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/watch/watch.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:flutter_mob/utils/utility.dart';
import 'package:flutter_svg/svg.dart';

class CardTopDeel extends StatelessWidget {
  final Watch watchData;
  final Function()? onClick;

  const CardTopDeel({super.key, required this.watchData, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 139,
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.blue300),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 22, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: TextNormal(
                        title: watchData.name,
                        fontName: AppThemes.dmSerifDisplay,
                        size: 22,
                        lineHeight: 1,
                        maxLine: 2,
                        colors: AppColors.kPrimaryColor,
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      TextNormal(
                        title:
                            "${Utility.formatNumberDoubleToInt(watchData.price)}\$",
                        fontName: AppThemes.dmSerifDisplay,
                        size: 20,
                        lineHeight: 1.2,
                        colors: AppColors.kPrimaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              watchData.photoUrls[0].contains("svg")
                  ? SvgPicture.network(
                      watchData.photoUrls[0],
                      width: 180,
                      height: 139,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      watchData.photoUrls[0],
                      width: 180,
                      height: 139,
                      fit: BoxFit.cover,
                    )
            ],
          ),
        ),
      ],
    );
  }
}
