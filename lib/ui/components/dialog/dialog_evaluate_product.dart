import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/ui/components/button/button_normal.dart';
import 'package:flutter_mob/ui/components/input/input_field.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogEvaluateProduct extends StatefulWidget {
  DialogEvaluateProduct({
    Key? key,
  }) : super(key: key);

  @override
  DialogEvaluateProductState createState() => DialogEvaluateProductState();
}

class DialogEvaluateProductState extends State<DialogEvaluateProduct> {
  TextEditingController textEditingController = TextEditingController();
  double rating = 0;

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
                    StarRating(
                      rating: rating,
                      onRatingChanged: (rating) =>
                          setState(() => this.rating = rating),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        TextNormal(
                          title: StringName.commentProduct,
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
                      maxLines: 2,
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
                            var comment = {
                              "rate": rating,
                              "comment": textEditingController.text
                            };
                            Navigator.pop(context, comment);
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
