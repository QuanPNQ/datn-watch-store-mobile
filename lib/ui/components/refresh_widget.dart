import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';

class RefreshWidget extends StatelessWidget {
  final Widget child;
  final Future Function() onRefresh;
  final GlobalKey<RefreshIndicatorState> keyRefresh;

  const RefreshWidget(
      {Key? key,
      required this.child,
      required this.onRefresh,
      required this.keyRefresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ? buildAndroidWidget() : buildIosWidget();
  }

  buildIosWidget() {
    return CustomScrollView(
      slivers: [
        Theme(
          data: ThemeData(
              cupertinoOverrideTheme:
                  const CupertinoThemeData(brightness: Brightness.dark)),
          child: CupertinoSliverRefreshControl(
            onRefresh: onRefresh,
          ),
        ),
        SliverToBoxAdapter(
          child: child,
        )
      ],
    );
  }

  buildAndroidWidget() {
    return RefreshIndicator(
        backgroundColor: AppColors.dPrimaryColor,
        color: AppColors.pPrimaryColor,
        child: child,
        onRefresh: onRefresh);
  }
}
