import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/watch/watch.dart';
import 'package:flutter_mob/ui/components/card/card_watch.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';

class OutstandingWatch extends StatefulWidget {
  const OutstandingWatch({super.key});

  @override
  State<OutstandingWatch> createState() => _OutstandingWatchState();
}

class _OutstandingWatchState extends State<OutstandingWatch> {
  List<Watch> listWatch = Constants.listMockDataWatch;

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
                title: StringName.outstandingWatch,
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
          height: 30,
        ),
        Wrap(
          runSpacing: 30,
          spacing: 20,
          children: listWatch
              .map((e) => CardWatch(
                    watchData: e,
                    isShowAddButton: false,
                    widthCard: (MediaQuery.of(context).size.width - 60) / 2,
                    heightCard: 260,
                    onClick: onCLickDetailWatch,
                  ))
              .toList(),
        )
      ],
    );
  }

  onCLickDetailWatch(Watch watch) {
    Navigator.pushNamed(context, Constants.watchDetailScreen);
  }
}
