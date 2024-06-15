import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/ui/components/app_bar/app_bar_title.dart';
import 'package:flutter_mob/ui/components/button/button_normal.dart';
import 'package:flutter_mob/ui/components/input/input_field.dart';
import 'package:flutter_mob/ui/components/scroll_behavior/scroll_behavior.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController editingOldPasswordController = TextEditingController();
  TextEditingController editingNewPasswordController = TextEditingController();
  TextEditingController editingConfirmNewPasswordController =
      TextEditingController();

  @override
  void initState() {
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
                appTitle: StringName.changePassword,
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
                            height: 60,
                          ),
                          InputField(
                              isObscureText: true,
                              labelText: StringName.inputOldPassword,
                              controller: editingOldPasswordController),
                          SizedBox(
                            height: 10,
                          ),
                          InputField(
                              isObscureText: true,
                              labelText: StringName.inputNewPassword,
                              controller: editingNewPasswordController),
                          SizedBox(
                            height: 10,
                          ),
                          InputField(
                              isObscureText: true,
                              labelText: StringName.inputConfirmNewPassword,
                              controller: editingConfirmNewPasswordController),
                          SizedBox(
                            height: 49,
                          ),
                          ButtonNormal(
                            text: StringName.change,
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
