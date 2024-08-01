import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/account/account_bloc.dart';
import 'package:flutter_mob/blocs/account/account_event.dart';
import 'package:flutter_mob/blocs/account/account_state.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/ui/components/app_bar/app_bar_title.dart';
import 'package:flutter_mob/ui/components/button/button_normal.dart';
import 'package:flutter_mob/ui/components/input/input_field.dart';
import 'package:flutter_mob/ui/components/scroll_behavior/scroll_behavior.dart';
import 'package:flutter_mob/utils/Loading_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
      listener: (context, state) async {
        if (state is AccountLoadingState) {
          LoadingHelper.showLoading(context);
        } else if (state is ChangePasswordSuccessState) {
          LoadingHelper.hideLoading(context);
          Fluttertoast.showToast(
              msg: "Cập nhật thành công",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (state is ChangePasswordErrorState) {
          LoadingHelper.hideLoading(context);
          Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.kPrimaryColor,
        body: SafeArea(
          child: Form(
            key: _formKey,
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
                                controller: editingOldPasswordController,
                                validator: validateEmpty,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              InputField(
                                isObscureText: true,
                                labelText: StringName.inputNewPassword,
                                controller: editingNewPasswordController,
                                validator: validateEmpty,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              InputField(
                                isObscureText: true,
                                labelText: StringName.inputConfirmNewPassword,
                                controller: editingConfirmNewPasswordController,
                                validator: validateConfirmPassword,
                              ),
                              SizedBox(
                                height: 49,
                              ),
                              ButtonNormal(
                                text: StringName.change,
                                width: 202,
                                onPressed: handleUpdate,
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

  String? validateConfirmPassword(value) {
    if (value == null || value.isEmpty) {
      return StringName.notAllowEmpty;
    }
    if (editingNewPasswordController.text !=
        editingConfirmNewPasswordController.text) {
      return StringName.passwordNotMatch;
    }
    return null;
  }

  handleChangePassword() {
    Navigator.pushNamed(context, Constants.changePasswordScreen);
  }

  handleUpdate() {
    if (_formKey.currentState?.validate() ?? false) {
      BlocProvider.of<AccountBloc>(context).add(ChangePasswordEvent(
        newPassword: editingNewPasswordController.text,
        oldPassword: editingOldPasswordController.text,
      ));
    }
  }
}
