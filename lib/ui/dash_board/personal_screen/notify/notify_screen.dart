import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/ui/components/app_bar/app_bar_title.dart';
import 'package:flutter_mob/ui/components/card/card_notification.dart';
import 'package:flutter_mob/ui/components/scroll_behavior/scroll_behavior.dart';
import 'package:flutter_mob/models/notify/notification.dart' as model;

class NotifyScreen extends StatefulWidget {
  const NotifyScreen({super.key});

  @override
  State<NotifyScreen> createState() => _NotifyScreenState();
}

class _NotifyScreenState extends State<NotifyScreen> {
  List<model.Notification> listNotification = Constants.mockListNotification;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            AppBarTitle(
                appTitle: StringName.notification,
                fontName: AppThemes.jaldi,
                fontSize: 20),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: CustomScrollBehavior(),
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    ...listNotification
                        .map((e) => CardNotification(notification: e))
                        .toList()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
