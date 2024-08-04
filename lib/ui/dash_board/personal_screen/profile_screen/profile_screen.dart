import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/account/account_bloc.dart';
import 'package:flutter_mob/blocs/account/account_event.dart';
import 'package:flutter_mob/blocs/account/account_state.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/images.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/account/account.dart';
import 'package:flutter_mob/repositories/authentication/auth_repository.dart';
import 'package:flutter_mob/ui/components/app_bar/app_bar_title.dart';
import 'package:flutter_mob/ui/components/button/button_normal.dart';
import 'package:flutter_mob/ui/components/input/input_field.dart';
import 'package:flutter_mob/ui/components/input_formatter/no_space_input_formatter.dart';
import 'package:flutter_mob/ui/components/scroll_behavior/scroll_behavior.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:flutter_mob/utils/Loading_helper.dart';
import 'package:flutter_mob/utils/pick_image_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Account? account;
  String? image;
  TextEditingController editingUsernameController = TextEditingController();
  TextEditingController editingEmailController = TextEditingController();
  TextEditingController editingPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getAccount();
    super.initState();
  }

  getAccount() async {
    account = await AuthRepository().getUser();
    if (account != null) {
      editingUsernameController.text = account!.userName;
      editingEmailController.text = account!.email;
      editingPasswordController.text = '12345678';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
      listener: (context, state) async {
        if (state is AccountLoadingState) {
          LoadingHelper.showLoading(context);
        } else if (state is UpdateProfileSuccessState) {
          LoadingHelper.hideLoading(context);
          Fluttertoast.showToast(
              msg: "Cập nhật thành công",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          setState(() async {
            await getAccount();
            image = null;
          });
        } else if (state is UpdateProfileErrorState) {
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
          child: Column(
            children: [
              AppBarTitle(
                  appTitle: StringName.personalInformation,
                  fontName: AppThemes.jaldi,
                  fontSize: 20),
              Expanded(
                child: ScrollConfiguration(
                  behavior: CustomScrollBehavior(),
                  child: Form(
                    key: _formKey,
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
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle),
                                        child: image != null
                                            ? Image.file(
                                                File(image!),
                                                fit: BoxFit.cover,
                                              )
                                            : account?.avatarUrl != null
                                                ? Image.network(
                                                    account!.avatarUrl!,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.asset(
                                                    AppImages
                                                        .imgAvatarUserDefault,
                                                    fit: BoxFit.cover,
                                                  ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: handlePickImage,
                                    child: Container(
                                      width: 37,
                                      height: 37,
                                      decoration: BoxDecoration(
                                          color: AppColors.yellow1,
                                          shape: BoxShape.circle),
                                      child: Icon(Icons.camera_alt_outlined,
                                          size: 20),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 80,
                              ),
                              InputField(
                                labelText: StringName.account,
                                hintText: StringName.fillYourAccount,
                                controller: editingUsernameController,
                                inputFormatters: [NoSpaceInputFormatter()],
                                validator: validateEmpty,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              InputField(
                                labelText: StringName.email,
                                hintText: StringName.fillYourEmail,
                                controller: editingEmailController,
                                inputFormatters: [NoSpaceInputFormatter()],
                                validator: validateEmail,
                              ),
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
                                onPressed: handleUpdate,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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

  String? validateEmail(value) {
    if (value == null || value.isEmpty) {
      return StringName.notAllowEmpty;
    }
    final emailRegExp = RegExp(Regex.email);
    if (!emailRegExp.hasMatch(value)) {
      return StringName.emailNotValid;
    }
    return null;
  }

  handleChangePassword() {
    Navigator.pushNamed(context, Constants.changePasswordScreen);
  }

  handleUpdate() {
    if (_formKey.currentState?.validate() ?? false) {
      BlocProvider.of<AccountBloc>(context).add(UpdateProfileEvent(
          userName: editingUsernameController.text.trim(),
          email: editingEmailController.text.trim(),
          filePath: image));
    }
  }

  handlePickImage() async {
    var a = await PickImageHelper.pickerFromGallery();
    if (a != null) {
      setState(() {
        image = a;
      });
    }
  }
}
