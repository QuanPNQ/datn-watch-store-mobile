import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/ui/components/button/button_normal.dart';
import 'package:flutter_mob/ui/components/input/input_field.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogCancelOrder extends StatefulWidget {
  DialogCancelOrder({
    Key? key,
  }) : super(key: key);

  @override
  DialogCancelOrderState createState() => DialogCancelOrderState();
}

class DialogCancelOrderState extends State<DialogCancelOrder> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 271.w,
      height: 150.h,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Dialog(
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
              SizedBox(
                height: 24.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        TextNormal(
                          title: StringName.reason,
                          colors: AppColors.bPrimaryColor,
                          fontName: AppThemes.spectral,
                          size: 18,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    InputField(
                      controller: textEditingController,
                      maxLines: 5,
                      fillColor: AppColors.grey1.withOpacity(0.2),
                      contentPadding: EdgeInsets.all(12),
                      onChange: (value) {
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ButtonNormal(
                          text: StringName.send,
                          width: 150,
                          height: 35,
                          radius: 6,
                          enabled: textEditingController.text.isNotEmpty,
                          onPressed: () {
                            Navigator.pop(context, textEditingController.text);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
