import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/models.dart';
import 'package:flutter_mob/ui/components/app_bar/app_bar_title.dart';
import 'package:flutter_mob/ui/components/app_bar/header_navigation_bar.dart';
import 'package:flutter_mob/ui/components/card/card_order_verify.dart';
import 'package:flutter_mob/ui/components/scroll_behavior/scroll_behavior.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<String> listTabTitle = Constants.listTabOrders;
  List<Order> listOrder = [
    Constants.mockDataOrder,
    Constants.mockDataOrder,
    Constants.mockDataOrder,
    Constants.mockDataOrder
  ];

  @override
  Widget build(BuildContext context) {
    listOrder = [
      Constants.mockDataOrder,
      Constants.mockDataOrder,
      Constants.mockDataOrder,
      Constants.mockDataOrder
    ];
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            AppBarTitle(
                appTitle: StringName.listOrder,
                fontName: AppThemes.jaldi,
                fontSize: 20),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Column(
                children: [
                  HeaderNavigationBar(
                      listTabTitle: listTabTitle, onTabSelected: onTabSelected),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: Container(
                      color: AppColors.oPrimaryColor,
                      child: ScrollConfiguration(
                        behavior: CustomScrollBehavior(),
                        child: ListView(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                ...listOrder
                                    .map((e) => CardOrderVerify(
                                          order: e,
                                        ))
                                    .toList(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  onTabSelected(int index) {}
}
