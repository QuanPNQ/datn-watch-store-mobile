import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/comment/comment.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardComment extends StatelessWidget {
  final Comment comment;

  const CardComment({super.key, required this.comment});

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
                child: comment.user.avatarUrl!.contains("svg")
                    ? SvgPicture.network(
                        comment.user.avatarUrl!,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        comment.user.avatarUrl!,
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
                  title: comment.user.name,
                  colors: AppColors.bPrimaryColor,
                  fontName: AppThemes.specialElite,
                ),
                SizedBox(
                  height: 4,
                ),
                TextNormal(
                  title: comment.content,
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
