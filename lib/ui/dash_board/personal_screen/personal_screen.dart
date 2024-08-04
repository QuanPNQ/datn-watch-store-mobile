import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/account/account_bloc.dart';
import 'package:flutter_mob/blocs/account/account_state.dart';
import 'package:flutter_mob/blocs/authentication/auth_bloc.dart';
import 'package:flutter_mob/blocs/authentication/auth_event.dart';
import 'package:flutter_mob/blocs/notify/notify_bloc.dart';
import 'package:flutter_mob/blocs/notify/notify_state.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/images.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/account/account.dart';
import 'package:flutter_mob/models/tab/tab_personal.dart';
import 'package:flutter_mob/repositories/authentication/auth_repository.dart';
import 'package:flutter_mob/storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  Account? account;
  int quantityNotify = 0;
  List<TabPersonal> listTab = [
    TabPersonal(
        icon: Icon(Icons.person, size: 36),
        title: StringName.accountInfo,
        route: Constants.profileScreen),
    TabPersonal(
        icon: Icon(Icons.notifications, size: 36),
        title: StringName.notification,
        route: Constants.notifyScreen),
    TabPersonal(
        icon: Icon(Icons.production_quantity_limits, size: 36),
        title: StringName.order,
        route: Constants.orderScreen),
    TabPersonal(
        icon: Icon(Icons.history_edu, size: 36),
        title: StringName.transactionHistories,
        route: Constants.transactionScreen),
    TabPersonal(
        icon: Icon(Icons.question_mark, size: 36),
        title: StringName.supportCenter,
        route: "route"),
  ];

  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() async {
    account = await AuthRepository().getUser();
    SharedPrefManager? sharedPrefManager =
        await SharedPrefManager.getInstance();
    quantityNotify = await sharedPrefManager!.getInt(
          SharedPrefManager.notifyKey,
        ) ??
        0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotifyBloc, NotifyState>(
      listener: (context, state) async {
        if (state is GetListNotifySuccessState) {
          setState(() {
            quantityNotify =
                state.listNotify.where((item) => item.isRead != true).length;
          });
        } else if (state is ReadNotifySuccessState) {
          setState(() {
            quantityNotify = state.quantityNotifyUnread;
          });
        }
      },
      child: BlocListener<AccountBloc, AccountState>(
        listener: (context, state) async {
          if (state is UpdateProfileSuccessState) {
            initData();
          }
        },
        child: Scaffold(
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
                  child: account?.avatarUrl != null
                      ? Image.network(
                          account!.avatarUrl!,
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
              if (account?.name != null)
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: TextNormal(
                    title: account!.name!,
                    colors: AppColors.bPrimaryColor,
                    fontWeight: FontWeight.w700,
                    size: 20,
                  ),
                ),
              if (account != null)
                TextNormal(
                  title: account!.email,
                  colors: AppColors.bPrimaryColor,
                  size: 18,
                ),
              SizedBox(
                height: 30,
              ),
              ...listTab.map((e) {
                int indexTab = listTab.indexOf(e);
                return GestureDetector(
                  onTap: () async {
                    if (indexTab == 4) {
                      if (!await launchUrl(
                          Uri.parse(Constants.urlSupportCenter))) {
                        throw Exception(
                            'Could not launch ${Constants.urlSupportCenter}');
                      }
                      return;
                    }
                    Navigator.pushNamed(context, e.route);
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(alignment: Alignment.topCenter, children: [
                          e.icon,
                          if (quantityNotify > 0 && indexTab == 1)
                            Container(
                              height: 16,
                              width: 16,
                              margin: EdgeInsets.only(top: 6, left: 24),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.red, shape: BoxShape.circle),
                              child: TextNormal(
                                  title: quantityNotify.toString(),
                                  fontName: AppThemes.sourceSans,
                                  lineHeight: 1,
                                  size: 12),
                            ),
                        ]),
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
                );
              }).toList(),
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
                    GestureDetector(
                      onTap: handleLogout,
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextNormal(
                          title: StringName.logout,
                          size: 20,
                          colors: AppColors.logoRed,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  handleLogout() {
    Navigator.pushNamedAndRemoveUntil(
        context, Constants.loginScreen, (route) => false);
    BlocProvider.of<AuthBloc>(context).add(LoggedOutEvent());
  }
}
