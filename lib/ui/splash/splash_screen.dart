import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/authentication/auth_bloc.dart';
import 'package:flutter_mob/blocs/authentication/auth_state.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/images.dart';
import 'package:flutter_mob/storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
        if (state is AuthAuthenticatedState) {
          await Future.delayed(const Duration(seconds: 3));
          Navigator.pushReplacementNamed(context, Constants.dashBoardScreen);
        } else if (state is AuthNotAuthenticatedState) {
          await Future.delayed(const Duration(seconds: 3));
          SharedPrefManager sharedPrefManager = SharedPrefManager();
          bool? isCompleteWalkThrough = sharedPrefManager
              .getBool(SharedPrefManager.isCompleteWalkThrough);
          if (isCompleteWalkThrough == true) {
            Navigator.pushReplacementNamed(context, Constants.loginScreen);
            return;
          }

          Navigator.pushReplacementNamed(context, Constants.onBoardingScreen);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              AppImages.imgBackgroundSplash,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
            ),
            Image.asset(
              AppImages.imgBlurBackground,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: EdgeInsets.only(top: 24),
              child: TextNormal(
                title: StringName.watchShop,
                size: 24,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
              ),
            )
          ],
        ),
      ),
    );
  }
}
