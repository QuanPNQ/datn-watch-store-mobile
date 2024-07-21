import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/cart/cart_bloc.dart';
import 'package:flutter_mob/blocs/cart/cart_event.dart';
import 'package:flutter_mob/blocs/cart/cart_state.dart';
import 'package:flutter_mob/blocs/product/product_bloc.dart';
import 'package:flutter_mob/blocs/product/product_event.dart';
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
import 'package:fluttertoast/fluttertoast.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  List<CartItem> listCart = [];
  bool isLoading = false;
  Timer? timerQuantity;

  @override
  void initState() {
    BlocProvider.of<CartBloc>(context).add(GetListCartEvent());
    super.initState();
  }

  double get total => listCart.fold(
        0.0,
        (previousValue, item) =>
            previousValue + (item.watch.price * item.quantity),
      );

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) async {
        if (state is GetListCartLoadingState) {
          setState(() {
            isLoading = true;
          });
        } else if (state is GetListCartSuccessState) {
          setState(() {
            isLoading = false;
            listCart = state.listCart;
          });
        } else if (state is GetListCartErrorState) {
          setState(() {
            isLoading = false;
            Fluttertoast.showToast(
                msg: state.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          });
        }
      },
      child: Scaffold(
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
                      !isLoading
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
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
                                                      onUpdateQuantity:
                                                          (quantity) {
                                                        handleUpdateQuantity(
                                                            e, quantity);
                                                      },
                                                    ))
                                                .toList(),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      TextNormal(
                                                        title: StringName.total,
                                                        colors: AppColors
                                                            .bPrimaryColor,
                                                        fontName: AppThemes
                                                            .specialElite,
                                                        size: 20,
                                                      ),
                                                      TextNormal(
                                                        title:
                                                            "${Utility.formatNumberDoubleToInt(total)}\$",
                                                        colors: AppColors
                                                            .bPrimaryColor,
                                                        fontName:
                                                            AppThemes.spirax,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                            )
                          : Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top: 70),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(
                                      color: Colors.blue,
                                      strokeWidth: 3,
                                    ),
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
      ),
    );
  }

  handleRemoveCartItem(CartItem cartItem) {
    int index = listCart.indexWhere((element) => element.id == cartItem.id);
    if (index >= 0) {
      int currentQuantity = listCart[index].quantity;
      timerQuantity?.cancel();
      timerQuantity = Timer(Duration(seconds: 2), () {
        BlocProvider.of<ProductBloc>(context).add(UpdateProductToCartEvent(
            watchId: cartItem.watch.id,
            quantity: currentQuantity,
            type: UpdateCartTypeEnum.MINUS,
            isShowToast: false));
      });
      listCart.removeAt(index);
      setState(() {});
    }
  }

  handleUpdateQuantity(CartItem cartItem, int quantity) {
    int index = listCart.indexWhere((element) => element.id == cartItem.id);
    if (index >= 0) {
      bool isPlus = quantity > listCart[index].quantity;
      listCart[index].quantity = quantity;
      timerQuantity?.cancel();
      timerQuantity = Timer(Duration(seconds: 2), () {
        BlocProvider.of<ProductBloc>(context).add(UpdateProductToCartEvent(
            watchId: cartItem.watch.id,
            quantity: quantity,
            type: isPlus ? UpdateCartTypeEnum.PLUS : UpdateCartTypeEnum.MINUS,
            isShowToast: false));
      });
      setState(() {});
    }
  }

  handlePayment() {
    Navigator.pushNamed(context, Constants.detailOrderScreen);
  }
}
