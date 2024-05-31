import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';

class InternetConnectedDialog extends StatefulWidget {
  const InternetConnectedDialog({
    Key? key,
  }) : super(key: key);

  @override
  _InternetConnectedDialogState createState() =>
      _InternetConnectedDialogState();
}

class _InternetConnectedDialogState extends State<InternetConnectedDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 22.w, right: 22.w, top: 22.h),
            child: Text(
              "Internet connected, do you want login.",
              style: TextStyle(
                  color: AppColors.hPrimaryColor,
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ProximaNovaA',
                  letterSpacing: 0.5),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.h, bottom: 18.h),
                child: Container(
                  width: 75.55.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: AppColors.jPrimaryColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(context,
                          Constants.onBoardingScreen, (route) => false);
                    },
                    child: Center(
                      child: Text(
                        "Yes",
                        style: TextStyle(
                            fontSize: 16.0.sp,
                            color: AppColors.sPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ProximaNovaA',
                            letterSpacing: 0.5.w),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h, bottom: 18.h),
                child: Container(
                  width: 75.55.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: AppColors.jPrimaryColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(
                        context,
                      );
                    },
                    child: Center(
                      child: Text(
                        "No",
                        style: TextStyle(
                            fontSize: 16.0.sp,
                            color: AppColors.sPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ProximaNovaA',
                            letterSpacing: 0.5.w),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
