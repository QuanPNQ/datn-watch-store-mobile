import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/ui/dash_board/dash_board_screen.dart';
import 'package:flutter_mob/ui/dash_board/watch_detail/watch_detail_screen.dart';
import 'package:flutter_mob/ui/forgot_password/forgot_password_screen.dart';
import 'package:flutter_mob/ui/login/login_screen.dart';
import 'package:flutter_mob/ui/onboarding/onboarding_screen.dart';
import 'package:flutter_mob/ui/signup/signup_screen.dart';
import 'package:flutter_mob/ui/splash/splash_screen.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  final args = settings.arguments;
  switch (settings.name) {
    case Constants.splashScreen:
      return generateRouter(widget: const SplashScreen());
    case Constants.onBoardingScreen:
      return generateRouter(widget: const OnBoardingScreen());
    case Constants.loginScreen:
      return generateRouter(widget: const LoginScreen());
    case Constants.signupScreen:
      return generateRouter(widget: const SignupScreen());
    case Constants.forgotPasswordScreen:
      return generateRouter(widget: const ForgotPasswordScreen());
    case Constants.dashBoardScreen:
      return generateRouter(widget: const DashBoardScreen());
    case Constants.watchDetailScreen:
      return generateRouter(widget: const WatchDetailScreen());
    default:
      throw ('This route name does not exit');
  }
}

generateRouter({required Widget widget}) {
  return MaterialPageRoute(builder: (context) => widget);
}
