import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/shipping_address/shipping_address.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';

class CardShippingAddress extends StatelessWidget {
  final ShippingAddress shippingAddress;
  final Function(ShippingAddress) onSelectAddress;
  final Function(ShippingAddress) onUpdateAddress;

  const CardShippingAddress(
      {super.key,
      required this.shippingAddress,
      required this.onSelectAddress,
      required this.onUpdateAddress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: GestureDetector(
        onTap: () => onSelectAddress(shippingAddress),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.grey3,
              border: Border.all(color: AppColors.grey4)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                shippingAddress.isDefault
                    ? Icons.adjust_rounded
                    : Icons.circle_outlined,
                color: shippingAddress.isDefault
                    ? AppColors.buttonRed
                    : AppColors.bPrimaryColor,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        TextNormal(
                          title: shippingAddress.receiver,
                          colors: AppColors.bPrimaryColor,
                          fontName: AppThemes.jaldi,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        TextNormal(
                          title: "|",
                          colors: AppColors.bPrimaryColor.withOpacity(0.5),
                          fontName: AppThemes.jaldi,
                          size: 14,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        TextNormal(
                          title: shippingAddress.phoneNumber,
                          colors: AppColors.bPrimaryColor.withOpacity(0.5),
                          fontName: AppThemes.jaldi,
                          size: 14,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    SizedBox(
                      height: 30,
                      child: TextNormal(
                        title: shippingAddress.address,
                        colors: AppColors.bPrimaryColor.withOpacity(0.5),
                        fontName: AppThemes.jaldi,
                        size: 14,
                        maxLine: 2,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    if (shippingAddress.isDefault)
                      Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.buttonRed),
                            borderRadius: BorderRadius.circular(1)),
                        child: Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: TextNormal(
                            title: "Mặc định",
                            colors: AppColors.buttonRed,
                            fontName: AppThemes.sourceSans,
                            size: 14,
                          ),
                        ),
                      )
                  ],
                ),
              ),
              SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTap: () => onUpdateAddress(shippingAddress),
                child: TextNormal(
                  title: "Sửa",
                  colors: AppColors.buttonRed,
                  fontName: AppThemes.jaldi,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
