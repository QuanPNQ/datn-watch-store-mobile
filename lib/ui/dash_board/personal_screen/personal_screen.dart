import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/images.dart';
import 'package:flutter_mob/models/account/user.dart';
import 'package:flutter_mob/models/tab/tab_personal.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  Account account = Constants.mockDataAccount;
  List<TabPersonal> listTab = [
    TabPersonal(
        icon: Icon(Icons.person, size: 36),
        title: StringName.accountInfo,
        route: Constants.profileScreen),
    TabPersonal(
        icon: Icon(Icons.notifications, size: 36),
        title: StringName.notification,
        route: "route"),
    TabPersonal(
        icon: Icon(Icons.production_quantity_limits, size: 36),
        title: StringName.order,
        route: "route"),
    TabPersonal(
        icon: Icon(Icons.question_mark, size: 36),
        title: StringName.supportCenter,
        route: "route"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(),
          SizedBox(
            height: 100,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(80),
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: account.avatarUrl != null
                  ? Image.network(
                      account.avatarUrl!,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      AppImages.imgAvatarUserDefault,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          if (account.name != null)
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: TextNormal(
                title: account.name!,
                colors: AppColors.bPrimaryColor,
                fontWeight: FontWeight.w700,
                size: 20,
              ),
            ),
          TextNormal(
            title: account.email,
            colors: AppColors.bPrimaryColor,
            size: 18,
          ),
          SizedBox(
            height: 30,
          ),
          ...listTab
              .map((e) => GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, e.route);
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          e.icon,
                          SizedBox(
                            width: 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextNormal(
                              title: e.title,
                              size: 20,
                              colors: AppColors.bPrimaryColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
              .toList(),
          SizedBox(
            height: 14,
          ),
          Divider(
            height: 0.5,
            thickness: 0.5,
            color: AppColors.bPrimaryColor,
          ),
          SizedBox(
            height: 14,
          ),
          Container(
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.power_settings_new,
                  size: 36,
                  color: AppColors.logoRed,
                ),
                SizedBox(
                  width: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextNormal(
                    title: StringName.logout,
                    size: 20,
                    colors: AppColors.logoRed,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
