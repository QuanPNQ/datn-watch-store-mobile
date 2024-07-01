import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/ui/components/scroll_behavior/scroll_behavior.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:flutter_mob/ui/dash_board/home/classify_watch/classify_watch.dart';
import 'package:flutter_mob/ui/dash_board/home/outstanding_watch/outstanding_watch.dart';
import 'package:flutter_mob/ui/dash_board/home/search_brand/search_brand.dart';
import 'package:flutter_mob/ui/dash_board/home/top_deels/top_deels.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
          child: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextNormal(
                    title: StringName.hello,
                    fontName: AppThemes.dmSerifDisplay,
                    size: 34,
                    lineHeight: 1.4,
                    colors: AppColors.blue300,
                  ),
                  TextNormal(
                    title: StringName.pickWatchThatYouWant,
                    fontName: AppThemes.dmSerifDisplay,
                    size: 16,
                    lineHeight: 2,
                    colors: AppColors.blue300,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ClassifyWatch(),
            SizedBox(
              height: 35,
            ),
            TopDeels(),
            SizedBox(
              height: 52,
            ),
            SearchBrand(),
            SizedBox(
              height: 30,
            ),
            OutstandingWatch(),
            SizedBox(
              height: 85,
            )
          ],
        ),
      )),
    );
  }
}
