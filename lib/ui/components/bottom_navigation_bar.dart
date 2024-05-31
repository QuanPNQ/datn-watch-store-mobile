import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final double iconSize;
  final Color? backgroundColor;
  final Duration animationDuration;
  final List<BottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double containerHeight;

  const BottomNavigationBar({
    Key? key,
    this.selectedIndex = 0,
    this.iconSize = 20,
    this.backgroundColor,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    required this.containerHeight,
    required this.items,
    required this.onItemSelected,
  })  : assert(items.length >= 2 && items.length <= 5),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Theme.of(context).bottomAppBarColor;
    final screenWidth = ScreenUtil().screenWidth;

    return Container(
      width: double.infinity,
      height: containerHeight,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: items.map((item) {
          var index = items.indexOf(item);
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onItemSelected(index),
            child: Container(
              padding: EdgeInsets.only(bottom: 22.h),
              height: containerHeight,
              child: _ItemWidget(
                item: item,
                iconSize: iconSize,
                isSelected: index == selectedIndex,
                backgroundColor: bgColor,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final double iconSize;
  final bool isSelected;
  final BottomNavBarItem item;
  final Color backgroundColor;
  final double? witdh;

  const _ItemWidget({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.backgroundColor,
    required this.iconSize,
    this.witdh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      selected: isSelected,
      child: IntrinsicHeight(
        child: Container(
          width: witdh,
          // color: Colors.red,
          // padding: EdgeInsets.only(top: 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: DefaultTextStyle.merge(
                  style: TextStyle(
                    color: isSelected ? item.activeColor : item.inactiveColor,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  textAlign: item.textAlign,
                  child: item.title,
                ),
              ),
              if (isSelected) SizedBox(height: 12.h),
              if (isSelected)
                IconTheme(
                  data: IconThemeData(
                    size: iconSize,
                    color: isSelected
                        ? item.activeColor.withOpacity(1)
                        : item.inactiveColor ?? item.activeColor,
                  ),
                  child: item.icon,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavBarItem {
  final Widget icon;
  final Widget title;
  final Color activeColor;
  final Color? inactiveColor;
  final TextAlign? textAlign;

  BottomNavBarItem({
    required this.icon,
    required this.title,
    this.activeColor = AppColors.heroRed,
    this.inactiveColor = AppColors.grey500,
    this.textAlign,
  });
}
