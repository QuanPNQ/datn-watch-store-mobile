import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Constants.signupScreen);
            },
            child: TextNormal(
              lineHeight: 1.3.h,
              size: 14.sp,
              title: 'OnBoardingScreen',
              colors: AppColors.mediumWhite,
            ),
          ),
        ),
      ),
    );
  }
}
