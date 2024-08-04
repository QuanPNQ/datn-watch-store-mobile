import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/models/transaction/transaction.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:flutter_mob/utils/date_time_helper.dart';

class CardTransaction extends StatelessWidget {
  final Transaction transaction;

  const CardTransaction({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(4)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.history_edu, size: 36),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextNormal(
                        title: transaction.content,
                        colors: AppColors.bPrimaryColor,
                        fontWeight: FontWeight.w700,
                        size: 18,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      TextNormal(
                        title:
                            'Thời gian: ${DateTimeHelper.getUtcToLocalTime(transaction.createdAt, format: DateFormat.dateHour)}',
                        colors: AppColors.bPrimaryColor,
                        size: 14,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextNormal(
                            title: 'Số tiền: ',
                            size: 14,
                            colors: AppColors.bPrimaryColor,
                          ),
                          TextNormal(
                            title: "${transaction.amount}\$",
                            size: 16,
                            colors: transaction.amount < 0
                                ? Colors.red
                                : Colors.green,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
