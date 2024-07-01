import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/login/login_bloc.dart';
import 'package:flutter_mob/blocs/login/login_event.dart';
import 'package:flutter_mob/blocs/login/login_state.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/images.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/ui/components/button/button_normal.dart';
import 'package:flutter_mob/ui/components/input/input_field.dart';
import 'package:flutter_mob/ui/components/input_formatter/no_space_input_formatter.dart';
import 'package:flutter_mob/ui/components/scroll_behavior/scroll_behavior.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/utils/Loading_helper.dart';
import 'package:flutter_mob/utils/dialog_helper.dart';

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
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    editingUsernameController.dispose();
    editingPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is LoginLoadingState) {
          LoadingHelper.showLoading(context);
        } else if (state is LoginSuccessState) {
          Navigator.pushReplacementNamed(context, Constants.dashBoardScreen);
        } else if (state is LoginErrorState) {
          LoadingHelper.hideLoading(context);
          DialogHelper.showDialogNotify(
              context: context,
              title: StringName.loginError,
              content: state.message);
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppColors.kPrimaryColor,
        body: Stack(
          alignment: Alignment.topRight,
          children: [
            Image.asset(AppImages.imgBackgroundLogin),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: ScrollConfiguration(
                      behavior: CustomScrollBehavior(),
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height -
                              MediaQuery.of(context).viewPadding.top -
                              MediaQuery.of(context).padding.top,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 250),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextNormal(
                                  title: StringName.login,
                                  size: 36,
                                  fontName: AppThemes.italianno,
                                  colors: AppColors.bPrimaryColor,
                                ),
                              ),
                              SizedBox(height: 42),
                              InputField(
                                labelText: StringName.account,
                                hintText: StringName.fillYourAccount,
                                inputFormatters: [NoSpaceInputFormatter()],
                                controller: editingUsernameController,
                                validator: validateEmpty,
                              ),
                              SizedBox(height: 12),
                              InputField(
                                labelText: StringName.password,
                                hintText: StringName.fillYourPassword,
                                controller: editingPasswordController,
                                isObscureText: true,
                                validator: validateEmpty,
                              ),
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
                                  SizedBox(width: 4)
                                ],
                              ),
                              const Spacer(),
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
                              SizedBox(height: 12),
                              ButtonNormal(
                                text: StringName.login1,
                                onPressed: handleLogin,
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String? validateEmpty(value) {
    if (value == null || value.isEmpty) {
      return StringName.notAllowEmpty;
    }
    return null;
  }

  handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      BlocProvider.of<LoginBloc>(context).add(LoginAuthEvent(
        userName: editingUsernameController.text.trim(),
        password: editingPasswordController.text.trim(),
      ));
    }
  }

  handleRegister() {
    Navigator.pushNamed(context, Constants.signupScreen);
  }

  handleForgotPassword() {
    Navigator.pushNamed(context, Constants.forgotPasswordScreen);
  }
}
