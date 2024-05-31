import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogTimeOut extends StatefulWidget {
  final String title;
  final Function goBack;
  final Function waiting;
  final String okButton;

  DialogTimeOut(
      {Key? key,
      required this.title,
      required this.goBack,
      required this.waiting,
      this.okButton = 'Allow'})
      : super(key: key);

  @override
  DialogTimeOutState createState() => DialogTimeOutState();
}

class DialogTimeOutState extends State<DialogTimeOut> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: AppColors.blurGray,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: 16.w, right: 16.w, top: 16.h, bottom: 16.h),
            child: Text(
              "${widget.title}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.0.sp,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Arial',
                  letterSpacing: 0.5),
            ),
          ),
          Divider(
            height: 0.5.h,
            color: AppColors.lineGray,
          ),
          Container(
            height: 44.5.h,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 11.h, bottom: 9.5.h),
                    child: InkWell(
                      onTap: () {
                        widget.goBack();
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 17.0.sp,
                              color: AppColors.systemBlue,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Arial',
                              letterSpacing: 0.5.w),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: AppColors.lineGray,
                  width: 0.5.h,
                  height: 44.5.h,
                ), //
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 11.h, bottom: 9.5.h),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        widget.waiting();
                      },
                      child: Center(
                        child: Text(
                          widget.okButton,
                          style: TextStyle(
                              fontSize: 17.0.sp,
                              color: AppColors.systemBlue,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Arial',
                              letterSpacing: 0.5.w),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
