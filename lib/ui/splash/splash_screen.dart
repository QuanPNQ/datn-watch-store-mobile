import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/images.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
        const Duration(milliseconds: 2000),
        () => Navigator.pushReplacementNamed(
            context, Constants.onBoardingScreen));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            TextNormal(
                title: 'Splash Screen',
                size: 16.sp,
                colors: AppColors.purple,
                lineHeight: 1)
          ],
        ),
      ),
    );
  }
}
