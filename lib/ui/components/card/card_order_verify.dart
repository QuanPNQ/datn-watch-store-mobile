import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/models.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:flutter_mob/utils/utility.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardOrderVerify extends StatelessWidget {
  final Order order;

  const CardOrderVerify({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    double discountPercent = 0.03;
    double subtotal = order.listWatch.fold(
      0.0,
      (previousValue, item) =>
          previousValue + (item.watch.price * item.quantity),
    );
    double discount = (discountPercent * subtotal).toInt().toDouble();
    double total = subtotal - discount;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.5),
      child: Container(
        color: AppColors.kPrimaryColor,
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextNormal(
                    title: Constants.getStatusOrder(order.status),
                    colors: AppColors.bPrimaryColor,
                    fontName: AppThemes.specialElite,
                    size: 14,
                  ),
                  TextNormal(
                    title: StringName.viewDetail,
                    colors: AppColors.bPrimaryColor,
                    fontName: AppThemes.specialElite,
                    size: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: AppColors.grey4,
            ),
            SizedBox(
              height: 8,
            ),
            ...order.listWatch.map((e) {
              return Container(
                height: 64,
                padding: EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(color: AppColors.grey4),
                )),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: e.watch.photoUrls[0].contains("svg")
                          ? SvgPicture.network(e.watch.photoUrls[0])
                          : Image.network(e.watch.photoUrls[0]),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          TextNormal(
                            title: e.watch.name,
                            colors: AppColors.bPrimaryColor,
                            fontName: AppThemes.specialElite,
                            size: 15,
                            maxLine: 1,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          TextNormal(
                            title:
                                "${Utility.formatNumberDoubleToInt(e.watch.price)}\$",
                            colors: AppColors.bPrimaryColor,
                            fontName: AppThemes.spicyRice,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: TextNormal(
                        title: 'x' + e.quantity.toString(),
                        colors: AppColors.bPrimaryColor,
                        fontName: AppThemes.spectral,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
              );
            }).toList(),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextNormal(
                    title: "${order.listWatch.length} sản phẩm",
                    colors: AppColors.bPrimaryColor,
                    fontName: AppThemes.specialElite,
                    size: 14,
                  ),
                  Row(
                    children: [
                      TextNormal(
                        title: StringName.totalPayment,
                        colors: AppColors.bPrimaryColor,
                        fontName: AppThemes.specialElite,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      TextNormal(
                        title: "${Utility.formatNumberDoubleToInt(total)}\$",
                        colors: AppColors.bPrimaryColor,
                        fontName: AppThemes.specialElite,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: AppColors.grey4,
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextNormal(
                    title: StringName.codeOrder,
                    colors: AppColors.bPrimaryColor,
                    fontName: AppThemes.specialElite,
                    size: 14,
                  ),
                  TextNormal(
                    title: order.codeOrder,
                    colors: AppColors.bPrimaryColor,
                    fontName: AppThemes.specialElite,
                    size: 14,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
