import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularProgress extends StatefulWidget {
  final Widget child;
  final AnimationController animationController;
  final Animation<double> animation;

  const CircularProgress({
    Key? key,
    required this.child,
    required this.animationController,
    required this.animation,
  }) : super(key: key);

  @override
  _CircularProgressState createState() => _CircularProgressState();
}

class _CircularProgressState extends State<CircularProgress> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CircularStepProgressIndicator(
      totalSteps: 100,
      currentStep: widget.animation.value.toInt(),
      padding: 0,
      unselectedColor: Colors.transparent,
      width: 220.w,
      height: 220.w,
      child: widget.child,
      selectedStepSize: 13.sp,
      removeRoundedCapExtraAngle: false,
      roundedCap: (_, __) => true,
      gradientColor: const RadialGradient(
          center: Alignment(-0.8, -2),
          colors: [
            Color.fromRGBO(255, 255, 255, 1),
            Color.fromRGBO(82, 111, 255, 1)
          ],
          radius: 1),
    );
  }
}
