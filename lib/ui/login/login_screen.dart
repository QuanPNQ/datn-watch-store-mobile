import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mob/blocs/authentication/auth_bloc.dart';
import 'package:flutter_mob/blocs/authentication/auth_state.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/ui/components/app_bar/app_bar_title.dart';
import 'package:flutter_mob/utils/Loading_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.grey900,
        appBar: AppBar(
          centerTitle: true,
          title: const AppBarTitle(
            appTitle: "Sign In",
          ),
          toolbarHeight: 64.h,
          backgroundColor: AppColors.grey900,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(1.h),
              child: Container(
                color: AppColors.lightWhite,
                height: 1.h,
              )),
        ),
        body: SafeArea(
          child: Center(),
        ),
      ),
    );
  }
}
