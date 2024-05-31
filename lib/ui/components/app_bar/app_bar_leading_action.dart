import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/images.dart';

class AppBarLeadingAction extends StatelessWidget {
  AppBarLeadingAction({Key? key, this.onPressed = null}) : super(key: key);
  final ValueGetter<void>? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 11.h, bottom: 11.h, left: 24.w),
      decoration: BoxDecoration(
          color: AppColors.gray900,
          borderRadius: BorderRadius.all(Radius.circular(12.r))),
      child: InkWell(
        child: RotatedBox(
            quarterTurns: 2,
            child: Image.asset(AppImages.iconChevronRightWhite,
                width: 6.w, height: 12.h,color: AppColors.whiteHightEmphasis,)),
        onTap: onPressed ?? () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
