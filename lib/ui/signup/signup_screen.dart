import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mob/blocs/authentication/auth_bloc.dart';
import 'package:flutter_mob/blocs/authentication/auth_state.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:flutter_mob/utils/Loading_helper.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.grey900,
        body: Padding(
            padding: EdgeInsets.only(top: 64.h),
            child: MultiBlocListener(
              listeners: [
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) async {
                    if (state is AuthLoadingState) {
                      LoadingHelper.showLoading(context);
                    } else if (state is AuthLoginSuccessState) {
                      LoadingHelper.hideLoading(context);
                    } else if (state is AuthErrorState) {
                      LoadingHelper.hideLoading(context);
                    }
                  },
                ),
              ],
              child: Center(
                child: TextNormal(
                  title: 'Create Account',
                  size: 16.sp,
                  colors: Colors.white,
                  lineHeight: 1.4.h,
                ),
              ),
            )));
  }
}
