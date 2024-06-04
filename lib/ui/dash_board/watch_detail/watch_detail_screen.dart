import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/comment/comment.dart';
import 'package:flutter_mob/models/watch/watch.dart';
import 'package:flutter_mob/ui/components/app_bar/app_bar_title.dart';
import 'package:flutter_mob/ui/components/button/button_normal.dart';
import 'package:flutter_mob/ui/components/card/card_comment.dart';
import 'package:flutter_mob/ui/components/scroll_behavior/scroll_behavior.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:flutter_mob/utils/utility.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WatchDetailScreen extends StatefulWidget {
  const WatchDetailScreen({super.key});

  @override
  State<WatchDetailScreen> createState() => _WatchDetailScreenState();
}

class _WatchDetailScreenState extends State<WatchDetailScreen> {
  Watch watch = Constants.mockDataWatch;
  List<Comment> listComment = Constants.listMockDataComment;
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            AppBarTitle(appTitle: watch.name),
            Expanded(
              child: ScrollConfiguration(
                behavior: CustomScrollBehavior(),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 40,
                            height: MediaQuery.of(context).size.width - 40,
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                                color: AppColors.grey3,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: AppColors.grey4)),
                            child: watch.photoUrls[0].contains("svg")
                                ? SvgPicture.network(watch.photoUrls[0])
                                : Image.network(watch.photoUrls[0]),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 7.0),
                                  child: TextNormal(
                                    title: watch.name,
                                    colors: AppColors.bPrimaryColor,
                                    fontName: AppThemes.specialElite,
                                    size: 20,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: handleDecreaseQuantity,
                                    child: Container(
                                      width: 37,
                                      height: 37,
                                      decoration: BoxDecoration(
                                          color: AppColors.yellow1,
                                          shape: BoxShape.circle),
                                      child: Icon(
                                        Icons.remove,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: TextNormal(
                                      title: quantity.toString(),
                                      colors: AppColors.bPrimaryColor,
                                      fontName: AppThemes.sourceSans,
                                      fontWeight: FontWeight.w600,
                                      size: 18,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: handleIncreaseQuantity,
                                    child: Container(
                                      width: 37,
                                      height: 37,
                                      decoration: BoxDecoration(
                                          color: AppColors.yellow1,
                                          shape: BoxShape.circle),
                                      child: Icon(
                                        Icons.add,
                                        size: 18,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          TextNormal(
                            title:
                                "${Utility.formatNumberDoubleToInt(watch.price)}\$",
                            colors: AppColors.bPrimaryColor,
                            fontName: AppThemes.spicyRice,
                            size: 20,
                          ),
                          SizedBox(
                            height: 38,
                          ),
                          TextNormal(
                            title: watch.description,
                            colors: AppColors.bPrimaryColor,
                            fontName: AppThemes.spectral,
                            size: 20,
                          ),
                          SizedBox(
                            height: 38,
                          ),
                          ButtonNormal(text: StringName.addToCart),
                          SizedBox(
                            height: 38,
                          ),
                          TextNormal(
                            title: StringName.comment,
                            colors: AppColors.bPrimaryColor,
                            fontName: AppThemes.specialElite,
                            size: 20,
                          ),
                          SizedBox(
                            height: listComment.isNotEmpty ? 8 : 20,
                          ),
                          listComment.isNotEmpty
                              ? Column(
                                  children: listComment
                                      .map((e) => CardComment(
                                            comment: e,
                                          ))
                                      .toList(),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextNormal(
                                      title: StringName.noComment,
                                      colors: AppColors.bPrimaryColor,
                                      fontName: AppThemes.spectral,
                                      size: 18,
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  handleDecreaseQuantity() {
    if (quantity == 1) return;
    setState(() {
      quantity--;
    });
  }

  handleIncreaseQuantity() {
    setState(() {
      quantity++;
    });
  }
}
