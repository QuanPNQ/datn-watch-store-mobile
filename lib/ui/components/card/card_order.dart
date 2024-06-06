import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/models.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:flutter_mob/utils/utility.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardOrder extends StatelessWidget {
  final OrderItem orderItem;

  const CardOrder({
    super.key,
    required this.orderItem,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.5),
      child: Container(
        height: 64,
        padding: EdgeInsets.only(left: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.grey3,
            border: Border.all(color: AppColors.grey4)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: orderItem.watch.photoUrls[0].contains("svg")
                  ? SvgPicture.network(orderItem.watch.photoUrls[0])
                  : Image.network(orderItem.watch.photoUrls[0]),
            ),
            SizedBox(
              width: 7,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  TextNormal(
                    title: orderItem.watch.name,
                    colors: AppColors.bPrimaryColor,
                    fontName: AppThemes.specialElite,
                    size: 15,
                    maxLine: 1,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  TextNormal(
                    title:
                        "${Utility.formatNumberDoubleToInt(orderItem.watch.price)}\$",
                    colors: AppColors.bPrimaryColor,
                    fontName: AppThemes.spicyRice,
                    size: 16,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: TextNormal(
                title: 'x' + orderItem.quantity.toString(),
                colors: AppColors.bPrimaryColor,
                fontName: AppThemes.spectral,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }
}
