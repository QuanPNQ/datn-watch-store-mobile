import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/discount/discount.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:intl/intl.dart' as intl;

class CardDiscount extends StatelessWidget {
  final Discount discount;
  final bool isSelected;
  final Function(Discount) onSelectDiscount;

  const CardDiscount({
    super.key,
    required this.discount,
    required this.isSelected,
    required this.onSelectDiscount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: GestureDetector(
        onTap: () => onSelectDiscount(discount),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.grey3,
              border: Border.all(color: AppColors.grey4)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextNormal(
                      title:
                          "Giảm giá ${discount.discountValue.floor()}${discount.discountType == DiscountType.PERCENT ? "%" : "\$"}",
                      colors: AppColors.bPrimaryColor,
                      fontName: AppThemes.jaldi,
                      fontWeight: FontWeight.w700,
                      size: 18,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    TextNormal(
                      title: discount.content,
                      colors: AppColors.bPrimaryColor,
                      fontName: AppThemes.jaldi,
                    ),
                    if (discount.expirationDate != null)
                      Column(
                        children: [
                          SizedBox(
                            height: 3,
                          ),
                          TextNormal(
                            title:
                                "HSD: ${intl.DateFormat(DateFormat.expirationDiscount).format(discount.expirationDate!)}",
                            colors: AppColors.bPrimaryColor.withOpacity(0.5),
                            fontName: AppThemes.jaldi,
                            size: 14,
                          ),
                        ],
                      ),
                    SizedBox(
                      width: 3,
                    ),
                  ],
                ),
              ),
              Icon(
                isSelected ? Icons.adjust_rounded : Icons.circle_outlined,
                color:
                    isSelected ? AppColors.buttonRed : AppColors.bPrimaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
