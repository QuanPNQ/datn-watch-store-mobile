import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'dots_decorator.dart';
import 'dots_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DotLoadingIndicator extends StatefulWidget {
  const  DotLoadingIndicator({Key? key}) : super(key: key);

  @override
  _DotLoadingIndicatorState createState() => _DotLoadingIndicatorState();
}

class _DotLoadingIndicatorState extends State<DotLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));

    _animation = Tween<double>(
      begin: 0,
      end: 3,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear))
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
    _controller.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      dotsCount: 3,
      position: _animation.value,
      decorator: DotsDecorator(
        spacing: EdgeInsets.symmetric(horizontal: 4.w),
        size:  Size.square(6.w),
        activeSize:  Size(20.w, 6.w),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
        activeColor: AppColors.heroRed,
        color: AppColors.natureGrey,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
