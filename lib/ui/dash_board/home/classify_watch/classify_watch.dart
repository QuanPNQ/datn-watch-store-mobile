import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/models/watch/watch.dart';
import 'package:flutter_mob/ui/components/card/card_watch.dart';
import 'package:flutter_mob/ui/components/scroll_behavior/scroll_behavior.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';

class ClassifyWatch extends StatefulWidget {
  const ClassifyWatch({super.key});

  @override
  State<ClassifyWatch> createState() => _ClassifyWatchState();
}

class _ClassifyWatchState extends State<ClassifyWatch> {
  final List<String> listTabTitle = Constants.listTabClassifyWatch;
  final List<Watch> listWatch = Constants.listMockDataWatch;
  int indexSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: listTabTitle.map((e) {
                int index = listTabTitle.indexOf(e);
                bool isSelected = index == indexSelected;
                return GestureDetector(
                  onTap: () => onClickTab(index),
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    padding: isSelected
                        ? EdgeInsets.symmetric(horizontal: 18)
                        : null,
                    decoration: isSelected
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.yellow1)
                        : null,
                    child: TextNormal(
                      title: e,
                      colors: isSelected
                          ? AppColors.black1
                          : AppColors.grey2.withOpacity(0.6),
                    ),
                  ),
                );
              }).toList(),
            )),
        SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 386,
          child: ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20),
              separatorBuilder: (context, index) => SizedBox(
                width: 22,
              ),
              itemCount: listWatch.length,
              itemBuilder: (context, index) {
                return CardWatch(
                  watchData: listWatch[index],
                  onAdd: onClickAddWatch,
                  onClick: onCLickDetailWatch,
                );
              },
            ),
          ),
        )
      ],
    );
  }

  onClickTab(int index) {
    if (index == indexSelected) return;

    indexSelected = index;
    setState(() {});
  }

  onClickAddWatch() {}

  onCLickDetailWatch(Watch watch) {
    Navigator.pushNamed(context, Constants.watchDetailScreen);
  }
}
