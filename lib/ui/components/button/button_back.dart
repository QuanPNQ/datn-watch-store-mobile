import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../configs/colors.dart';
import '../../../configs/images.dart';

class ButtonBack extends StatelessWidget {
  final GestureTapCallback? onTap;

  const ButtonBack({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 11.h, bottom: 11.h, left: 24.w),
      decoration: BoxDecoration(
          color: AppColors.gray900,
          borderRadius: BorderRadius.all(Radius.circular(12.r))),
      child: InkWell(
        onTap: onTap ??
            () {
              Navigator.pop(context);
            },
        child: RotatedBox(
            quarterTurns: 2,
            child: Image.asset(AppImages.iconChevronRightWhite,
                width: 6.w, height: 12.h)),
      ),
    );
  }
}
