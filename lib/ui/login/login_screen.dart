import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/images.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/ui/components/button/button_normal.dart';
import 'package:flutter_mob/ui/components/input/input_field.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:flutter_mob/blocs/authentication/auth_bloc.dart';
import 'package:flutter_mob/blocs/authentication/auth_state.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/utils/Loading_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController editingUsernameController =
      TextEditingController();
  final TextEditingController editingPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthLoadingState) {
          LoadingHelper.showLoading(context);
        } else if (state is AuthLoginSuccessState) {
          LoadingHelper.hideLoading(context);
        } else if (state is AuthErrorState) {
          LoadingHelper.hideLoading(context);
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        // resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.kPrimaryColor,
        body: Stack(
          alignment: Alignment.topRight,
          children: [
            Image.asset(
              AppImages.imgBackgroundLogin,
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextNormal(
                        title: StringName.login,
                        size: 36,
                        fontName: AppThemes.italianno,
                        colors: AppColors.bPrimaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 42,
                    ),
                    InputField(
                        labelText: StringName.account,
                        hintText: StringName.fillYourAccount,
                        controller: editingUsernameController),
                    SizedBox(
                      height: 12,
                    ),
                    InputField(
                        labelText: StringName.password,
                        hintText: StringName.fillYourPassword,
                        controller: editingPasswordController),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: handleForgotPassword,
                          child: TextNormal(
                            title: StringName.forgotPassword,
                            fontName: AppThemes.jaldi,
                            colors: AppColors.bPrimaryColor,
                            lineHeight: 2,
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 122,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: handleRegister,
                          child: TextNormal(
                            title: StringName.notHaveAccount,
                            fontName: AppThemes.jaldi,
                            colors: AppColors.bPrimaryColor,
                            lineHeight: 2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    ButtonNormal(
                      text: StringName.login1,
                      onPressed: handleLogin,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  handleLogin() {
    Navigator.pushNamed(context, Constants.signupScreen);
  }

  handleRegister() {
    Navigator.pushNamed(context, Constants.signupScreen);
  }

  handleForgotPassword() {
    Navigator.pushNamed(context, Constants.forgotPasswordScreen);
  }
}
