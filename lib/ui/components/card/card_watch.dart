import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/images.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/watch/watch.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:flutter_mob/utils/utility.dart';
import 'package:flutter_svg/svg.dart';

class CardWatch extends StatelessWidget {
  final Watch watchData;
  final Function()? onClick;
  final Function()? onAdd;
  final bool isShowAddButton;
  final double widthCard;
  final double heightCard;

  const CardWatch(
      {super.key,
      required this.watchData,
      this.onClick,
      this.onAdd,
      this.widthCard = 187,
      this.heightCard = 386,
      this.isShowAddButton = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightCard,
      width: widthCard,
      child: GestureDetector(
        onTap: onClick,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
                margin: EdgeInsets.only(bottom: isShowAddButton ? 20 : 0),
                child: SvgPicture.asset(AppImages.imgSubtractWatch)),
            Column(
              children: [
                Expanded(
                    child: watchData.photoUrls[0].contains("svg")
                        ? SvgPicture.network(watchData.photoUrls[0])
                        : Image.network(watchData.photoUrls[0])),
                SizedBox(
                  height: 20,
                ),
                TextNormal(
                  title: watchData.name,
                  colors: AppColors.blue300,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: 5,
                ),
                TextNormal(
                  title:
                      "${Utility.formatNumberDoubleToInt(watchData.price)}\$",
                  size: 22,
                  fontName: AppThemes.dmSerifDisplay,
                  colors: AppColors.black1,
                ),
                SizedBox(
                  height: isShowAddButton ? 7 : 20,
                ),
                if (isShowAddButton)
                  GestureDetector(
                    onTap: onAdd,
                    child: Container(
                      width: 40,
                      height: 40,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.yellow1, shape: BoxShape.circle),
                      child: SvgPicture.asset(
                        AppImages.iconAdd,
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
