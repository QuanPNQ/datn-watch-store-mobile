import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/models/notify/notification.dart' as model;
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:timeago/timeago.dart' as timeago;

class CardNotification extends StatelessWidget {
  final model.Notification notification;
  final Function()? onClick;

  CardNotification({super.key, required this.notification, this.onClick});

  String get timeAgo => timeago.format(notification.createdAt, locale: 'vi');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                SizedBox(
                  width: 48,
                  height: 48,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(42),
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_n6izFRroRhsheVP266kuI6WWf6XtdqvPUg&usqp=CAU"),
                    ),
                  ),
                ),
                if (!notification.isRead)
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                  )
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextNormal(
                  title: notification.title,
                  colors: AppColors.bPrimaryColor,
                  fontWeight: FontWeight.w700,
                  size: 20,
                  maxLine: 1,
                ),
                SizedBox(
                  height: 4,
                ),
                TextNormal(
                  title: notification.message,
                  colors: AppColors.bPrimaryColor,
                  maxLine: 2,
                )
              ],
            )),
            SizedBox(
              width: 8,
            ),
            TextNormal(
              title: timeAgo,
              colors: AppColors.bPrimaryColor,
              size: 18,
            )
          ],
        ),
      ),
    );
  }
}
