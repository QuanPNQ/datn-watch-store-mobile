import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mob/ui/components/dialog/dialog_notify.dart';

class DialogHelper {
  static Future<void> showDialogNotify(
      {required BuildContext context,
      required String title,
      required String content,
      String? okButton,
      Function()? continueFunction}) async {
    await showDialog(
      barrierDismissible: true,
      barrierColor: Colors.black26,
      context: context,
      builder: (context) {
        return SizedBox(
            width: 271.w,
            height: 150.h,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: DialogNotify(
                title: title,
                content: content,
                okButton: okButton,
                continueFunction: continueFunction,
              ),
            ));
      },
    );
  }
}
