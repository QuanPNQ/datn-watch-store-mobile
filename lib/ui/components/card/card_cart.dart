import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/cart/cart_item.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:flutter_mob/utils/utility.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardCart extends StatelessWidget {
  final CartItem cartItem;
  final Function(int) onUpdateQuantity;
  final Function(CartItem) onRemoveCart;

  const CardCart(
      {super.key,
      required this.cartItem,
      required this.onUpdateQuantity,
      required this.onRemoveCart});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: Container(
        height: 112,
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.grey3,
            border: Border.all(color: AppColors.grey4)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: cartItem.watch.photoUrls[0].contains("svg")
                  ? SvgPicture.network(cartItem.watch.photoUrls[0])
                  : Image.network(cartItem.watch.photoUrls[0]),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 18,
                  ),
                  TextNormal(
                    title: cartItem.watch.name,
                    colors: AppColors.bPrimaryColor,
                    fontName: AppThemes.specialElite,
                    size: 15,
                    maxLine: 3,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  TextNormal(
                    title:
                        "${Utility.formatNumberDoubleToInt(cartItem.watch.price)}\$",
                    colors: AppColors.bPrimaryColor,
                    fontName: AppThemes.spicyRice,
                    size: 16,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    onRemoveCart(cartItem);
                  },
                  child: Icon(Icons.close),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: handleDecreaseQuantity,
                      child: Container(
                        width: 37,
                        height: 37,
                        decoration: BoxDecoration(
                            color: AppColors.yellow1, shape: BoxShape.circle),
                        child: Icon(
                          Icons.remove,
                          size: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextNormal(
                        title: cartItem.quantity.toString(),
                        colors: AppColors.bPrimaryColor,
                        fontName: AppThemes.sourceSans,
                        fontWeight: FontWeight.w600,
                        size: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: handleIncreaseQuantity,
                      child: Container(
                        width: 37,
                        height: 37,
                        decoration: BoxDecoration(
                            color: AppColors.yellow1, shape: BoxShape.circle),
                        child: Icon(
                          Icons.add,
                          size: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 18,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  handleIncreaseQuantity() {
    onUpdateQuantity(cartItem.quantity + 1);
  }

  handleDecreaseQuantity() {
    if (cartItem.quantity == 1) return;
    onUpdateQuantity(cartItem.quantity - 1);
  }
}
