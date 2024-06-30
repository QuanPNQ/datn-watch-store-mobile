import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/ui/components/button/button_normal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogNotify extends StatefulWidget {
  final String title;
  final String content;
  final String? okButton;
  final Function()? continueFunction;

  DialogNotify(
      {Key? key,
      required this.title,
      required this.content,
      this.okButton,
      this.continueFunction})
      : super(key: key);

  @override
  DialogNotifyState createState() => DialogNotifyState();
}

class DialogNotifyState extends State<DialogNotify> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: AppColors.kPrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.transparent,
                  child: Icon(
                    Icons.cancel_sharp,
                    color: AppColors.grey2,
                    size: 20,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 28, right: 28, top: 4.h),
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppThemes.sourceSans,
                  letterSpacing: 0.5),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 28, right: 28, top: 4.h),
            child: Text(
              "${widget.content}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  fontFamily: AppThemes.sourceSans,
                  letterSpacing: 0.5),
            ),
          ),
          if (widget.continueFunction != null)
            Column(
              children: [
                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ButtonNormal(
                    text: widget.okButton ?? StringName.confirm,
                    textColor: AppColors.kPrimaryColor,
                    backgroundColor: AppColors.systemBlue,
                    borderColor: Colors.transparent,
                    height: 40,
                    radius: 8,
                    onPressed: widget.continueFunction,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: Text(
                      StringName.cancel,
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.systemBlue,
                          fontWeight: FontWeight.normal,
                          fontFamily: AppThemes.sourceSans,
                          letterSpacing: 0.5.w),
                    ),
                  ),
                ),
              ],
            ),
          SizedBox(
            height: 24.h,
          )
        ],
      ),
    );
  }
}
