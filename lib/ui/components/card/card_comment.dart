import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/models.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardComment extends StatelessWidget {
  final Review review;

  const CardComment({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(37),
            child: SizedBox(
                width: 37,
                height: 37,
                child: review.account.avatarUrl!.contains("svg")
                    ? SvgPicture.network(
                        review.account.avatarUrl!,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        review.account.avatarUrl!,
                        fit: BoxFit.cover,
                      )),
          ),
          SizedBox(
            width: 4,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 4,
                ),
                TextNormal(
                  title: review.account.name!,
                  colors: AppColors.bPrimaryColor,
                  fontName: AppThemes.specialElite,
                ),
                SizedBox(
                  height: 4,
                ),
                StarRating(
                  rating: review.rate,
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
                SizedBox(
                  height: 8,
                ),
                TextNormal(
                  title: review.comment,
                  colors: AppColors.bPrimaryColor,
                  fontName: AppThemes.specialElite,
                  size: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
