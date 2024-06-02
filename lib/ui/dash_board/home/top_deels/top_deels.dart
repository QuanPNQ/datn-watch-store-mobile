import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/watch/watch.dart';
import 'package:flutter_mob/ui/components/card/card_top_deel.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';

class TopDeels extends StatefulWidget {
  const TopDeels({super.key});

  @override
  State<TopDeels> createState() => _TopDeelsState();
}

class _TopDeelsState extends State<TopDeels> {
  PageController pageController = PageController();
  List<Watch> listWatch = Constants.listMockTopDeels;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextNormal(
                title: StringName.topDeels,
                fontName: AppThemes.dmSerifDisplay,
                size: 22,
                lineHeight: 1.2,
                colors: AppColors.black1,
              ),
              TextNormal(
                title: StringName.all,
                size: 14,
                lineHeight: 1.5,
                colors: AppColors.blue300,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 139,
          child: PageView(
            controller: pageController,
            children: listWatch
                .map((e) => CardTopDeel(
                      watchData: e,
                      onClick: handleClickTopDeel(e),
                    ))
                .toList(),
          ),
        )
      ],
    );
  }

  handleClickTopDeel(Watch watch) {}
}
