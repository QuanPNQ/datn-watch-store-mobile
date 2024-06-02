import 'package:flutter/cupertino.dart';

class TabDashboard {
  final String icon;
  final Widget view;
  bool isSelected;

  TabDashboard(
      {required this.icon, required this.view, this.isSelected = false});
}
