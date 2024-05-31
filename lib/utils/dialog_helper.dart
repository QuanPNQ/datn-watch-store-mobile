import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mob/ui/components/dialog/dialog_time_out.dart';

class DialogHelper {
  static Future<void> showDialogConnectTimeOut(
      BuildContext context, String content, Function goBack, Function waiting,
      {String okButton = 'Allow'}) async {
    await showDialog(
      barrierDismissible: false,
      barrierColor: Colors.black26,
      context: context,
      builder: (context) {
        return SizedBox(
            width: 271.w,
            height: 150.h,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: DialogTimeOut(
                title: content,
                goBack: goBack,
                waiting: waiting,
                okButton: okButton,
              ),
            ));
      },
    );
  }
}
