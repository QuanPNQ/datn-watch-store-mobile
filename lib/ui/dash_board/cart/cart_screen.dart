import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/cart/cart_item.dart';
import 'package:flutter_mob/ui/components/app_bar/app_bar_title.dart';
import 'package:flutter_mob/ui/components/button/button_normal.dart';
import 'package:flutter_mob/ui/components/card/card_cart.dart';
import 'package:flutter_mob/ui/components/scroll_behavior/scroll_behavior.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:flutter_mob/utils/utility.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  List<CartItem> listCart = Constants.listMockCarts;

  double get total => listCart.fold(
        0.0,
        (previousValue, item) =>
            previousValue + (item.watch.price * item.quantity),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            AppBarTitle(appTitle: StringName.cart, isShowBackButton: false),
            Expanded(
              child: ScrollConfiguration(
                behavior: CustomScrollBehavior(),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: listCart.isNotEmpty ? 15 : 100,
                          ),
                          listCart.isNotEmpty
                              ? Column(
                                  children: [
                                    ...listCart
                                        .map((e) => CardCart(
                                              cartItem: e,
                                              onRemoveCart:
                                                  handleRemoveCartItem,
                                              onUpdateQuantity: (quantity) {
                                                handleUpdateQuantity(
                                                    e, quantity);
                                              },
                                            ))
                                        .toList(),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: AppColors.bPrimaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextNormal(
                                                title: StringName.total,
                                                colors: AppColors.bPrimaryColor,
                                                fontName:
                                                    AppThemes.specialElite,
                                                size: 20,
                                              ),
                                              TextNormal(
                                                title:
                                                    "${Utility.formatNumberDoubleToInt(total)}\$",
                                                colors: AppColors.bPrimaryColor,
                                                fontName: AppThemes.spirax,
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 37,
                                          ),
                                          ButtonNormal(
                                            text: StringName.payment,
                                            onPressed: handlePayment,
                                          ),
                                          SizedBox(
                                            height: 80,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextNormal(
                                      title: StringName.notAddProducts,
                                      colors: AppColors.bPrimaryColor,
                                      fontName: AppThemes.spectral,
                                      size: 18,
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  handleRemoveCartItem(CartItem cartItem) {
    int index = listCart.indexWhere((element) => element.id == cartItem.id);
    if (index >= 0) {
      listCart.removeAt(index);
      setState(() {});
    }
  }

  handleUpdateQuantity(CartItem cartItem, int quantity) {
    int index = listCart.indexWhere((element) => element.id == cartItem.id);
    if (index >= 0) {
      listCart[index].quantity = quantity;
      setState(() {});
    }
  }

  handlePayment() {
    Navigator.pushNamed(context, Constants.detailOrderScreen);
  }
}
