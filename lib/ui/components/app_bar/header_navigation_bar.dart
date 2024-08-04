import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/models/option.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';

class HeaderNavigationBar extends StatefulWidget {
  final List<Option> listTab;
  final Function(int) onTabSelected;

  const HeaderNavigationBar(
      {super.key, required this.listTab, required this.onTabSelected});

  @override
  State<HeaderNavigationBar> createState() => _HeaderNavigationBarState();
}

class _HeaderNavigationBarState extends State<HeaderNavigationBar> {
  int indexSelected = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widget.listTab.map((e) {
              int index = widget.listTab.indexOf(e);
              bool isSelected = index == indexSelected;
              return GestureDetector(
                onTap: () => onClickTab(index),
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.symmetric(horizontal: isSelected ? 18 : 9),
                  decoration: isSelected
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.yellow1)
                      : null,
                  child: TextNormal(
                    title: e.label,
                    colors: isSelected
                        ? AppColors.black1
                        : AppColors.grey2.withOpacity(0.6),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  onClickTab(int index) {
    if (index == indexSelected) return;

    indexSelected = index;
    widget.onTabSelected(indexSelected);
    setState(() {});
  }
}
