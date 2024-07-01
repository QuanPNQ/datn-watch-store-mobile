import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/images.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/account/account.dart';
import 'package:flutter_mob/ui/components/app_bar/app_bar_title.dart';
import 'package:flutter_mob/ui/components/button/button_normal.dart';
import 'package:flutter_mob/ui/components/input/input_field.dart';
import 'package:flutter_mob/ui/components/scroll_behavior/scroll_behavior.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Account account = Constants.mockDataAccount;
  TextEditingController editingUsernameController = TextEditingController();
  TextEditingController editingEmailController = TextEditingController();
  TextEditingController editingPasswordController = TextEditingController();

  @override
  void initState() {
    editingUsernameController.text = account.userName;
    editingEmailController.text = account.email;
    editingPasswordController.text = '12345678';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            AppBarTitle(
                appTitle: StringName.personalInformation,
                fontName: AppThemes.jaldi,
                fontSize: 20),
            Expanded(
              child: ScrollConfiguration(
                behavior: CustomScrollBehavior(),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(80),
                                  child: Container(
                                    width: 112,
                                    height: 112,
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle),
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
                              ),
                              Container(
                                width: 37,
                                height: 37,
                                decoration: BoxDecoration(
                                    color: AppColors.yellow1,
                                    shape: BoxShape.circle),
                                child:
                                    Icon(Icons.camera_alt_outlined, size: 20),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 80,
                          ),
                          InputField(
                              labelText: StringName.account,
                              hintText: StringName.fillYourAccount,
                              controller: editingUsernameController),
                          SizedBox(
                            height: 10,
                          ),
                          InputField(
                              labelText: StringName.email,
                              hintText: StringName.fillYourEmail,
                              controller: editingEmailController),
                          SizedBox(
                            height: 10,
                          ),
                          InputField(
                              isObscureText: true,
                              labelText: StringName.password,
                              hintText: StringName.fillYourPassword,
                              controller: editingPasswordController,
                              isReadOnly: true),
                          SizedBox(
                            height: 7,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: handleChangePassword,
                                child: TextNormal(
                                  title: StringName.changePassword,
                                  colors: AppColors.bPrimaryColor,
                                  fontName: AppThemes.jaldi,
                                  isUnderline: true,
                                ),
                              ),
                              SizedBox(
                                width: 7,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          ButtonNormal(
                            text: StringName.update,
                            width: 202,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  handleChangePassword() {
    Navigator.pushNamed(context, Constants.changePasswordScreen);
  }
}
