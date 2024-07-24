import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';

class CardPaymentMethod extends StatelessWidget {
  final String paymentMethod;
  final bool isSelected;
  final Function(String) onSelectPaymentMethod;

  const CardPaymentMethod({
    super.key,
    required this.paymentMethod,
    required this.isSelected,
    required this.onSelectPaymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: GestureDetector(
        onTap: () => onSelectPaymentMethod(paymentMethod),
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
                      title: paymentMethod == PaymentMethodType.CASH.name
                          ? StringName.paymentOnDelivery
                          : StringName.paymentViaVNPay,
                      colors: AppColors.bPrimaryColor,
                      fontName: AppThemes.jaldi,
                      fontWeight: FontWeight.w700,
                      size: 18,
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
