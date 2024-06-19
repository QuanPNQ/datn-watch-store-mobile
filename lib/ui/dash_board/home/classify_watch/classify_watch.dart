import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/models/watch/watch.dart';
import 'package:flutter_mob/ui/components/app_bar/header_navigation_bar.dart';
import 'package:flutter_mob/ui/components/card/card_watch.dart';
import 'package:flutter_mob/ui/components/scroll_behavior/scroll_behavior.dart';

class ClassifyWatch extends StatefulWidget {
  const ClassifyWatch({super.key});

  @override
  State<ClassifyWatch> createState() => _ClassifyWatchState();
}

class _ClassifyWatchState extends State<ClassifyWatch> {
  final List<String> listTabTitle = Constants.listTabClassifyWatch;
  final List<Watch> listWatch = Constants.listMockDataWatch;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderNavigationBar(
            listTabTitle: listTabTitle, onTabSelected: onTabSelected),
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

  onTabSelected(int index) {}

  onClickAddWatch() {}

  onCLickDetailWatch(Watch watch) {
    Navigator.pushNamed(context, Constants.watchDetailScreen);
  }
}
