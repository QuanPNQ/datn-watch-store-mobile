import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/images.dart';
import 'package:flutter_mob/models/tab/tab_dashboard.dart';
import 'package:flutter_mob/ui/dash_board/cart/cart_screen.dart';
import 'package:flutter_mob/ui/dash_board/home/home_screen.dart';
import 'package:flutter_mob/ui/dash_board/personal_screen/personal_screen.dart';
import 'package:flutter_mob/ui/dash_board/search/search_screen.dart';
import 'package:flutter_mob/utils/Loading_helper.dart';
import 'package:flutter_svg/svg.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  PageController pageController = PageController();
  final List<TabDashboard> lisTab = [
    TabDashboard(
        icon: AppImages.iconHome, view: HomeScreen(), isSelected: true),
    TabDashboard(icon: AppImages.iconSearch, view: SearchScreen()),
    TabDashboard(icon: AppImages.iconShoppingBag, view: CardScreen()),
    TabDashboard(icon: AppImages.iconUser, view: PersonalScreen()),
  ];

  @override
  void initState() {
    LoadingHelper.hideLoading(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.gray900,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: lisTab.map((e) => e.view).toList(),
          ),
          SafeArea(
            child: Container(
              height: 58,
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.yellow1,
              ),
              child: Row(
                children: lisTab.map((e) {
                  return Expanded(
                      child: GestureDetector(
                    onTap: () => onClickTab(e),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          color: Colors.transparent,
                          child: SvgPicture.asset(e.icon,
                              color: e.isSelected
                                  ? AppColors.blue300
                                  : AppColors.black2),
                        ),
                        if (e.isSelected)
                          Container(
                            height: 5,
                            width: 5,
                            margin: EdgeInsets.only(top: 43),
                            decoration: BoxDecoration(
                                color: AppColors.blue300,
                                shape: BoxShape.circle),
                          )
                      ],
                    ),
                  ));
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  onClickTab(TabDashboard tabDashboard) {
    if (tabDashboard.isSelected) return;

    int index = lisTab.indexOf(tabDashboard);
    pageController.jumpToPage(index);
    lisTab[index].isSelected = true;
    for (var i = 0; i < lisTab.length; i++) {
      if (i != index) {
        lisTab[i].isSelected = false;
      }
    }
    setState(() {});
  }
}
