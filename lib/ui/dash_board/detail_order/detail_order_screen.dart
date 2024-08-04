import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/cart/cart_bloc.dart';
import 'package:flutter_mob/blocs/cart/cart_event.dart';
import 'package:flutter_mob/blocs/order/order_bloc.dart';
import 'package:flutter_mob/blocs/order/order_event.dart';
import 'package:flutter_mob/blocs/order/order_state.dart';
import 'package:flutter_mob/blocs/shipping_address/shipping_address_bloc.dart';
import 'package:flutter_mob/blocs/shipping_address/shipping_address_event.dart';
import 'package:flutter_mob/blocs/shipping_address/shipping_address_state.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/images.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/discount/discount.dart';
import 'package:flutter_mob/models/order/order.dart';
import 'package:flutter_mob/models/shipping_address/shipping_address.dart';
import 'package:flutter_mob/ui/components/app_bar/app_bar_title.dart';
import 'package:flutter_mob/ui/components/button/button_normal.dart';
import 'package:flutter_mob/ui/components/card/card_order.dart';
import 'package:flutter_mob/ui/components/dialog/dialog_cancel_order.dart';
import 'package:flutter_mob/ui/components/scroll_behavior/scroll_behavior.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:flutter_mob/utils/Loading_helper.dart';
import 'package:flutter_mob/utils/date_time_helper.dart';
import 'package:flutter_mob/utils/dialog_helper.dart';
import 'package:flutter_mob/utils/utility.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class DetailOrderScreen extends StatefulWidget {
  final dynamic data;

  const DetailOrderScreen({super.key, required this.data});

  @override
  State<DetailOrderScreen> createState() => _DetailOrderScreenState();
}

class _DetailOrderScreenState extends State<DetailOrderScreen> {
  late Order order;
  bool isPaymentSuccess = false;

  double get total => order.totalAmount - calculateDiscount();

  double calculateDiscount() {
    if (order.status == OrderStatusType.PROCESSING && order.discount != null) {
      return order.discount!.discountType == DiscountType.PERCENT.name
          ? (order.discount!.discountValue / 100 * (order.totalAmount))
              .toInt()
              .toDouble()
          : order.discount!.discountValue;
    }

    return order.discountAmount ?? 0;
  }

  @override
  void initState() {
    order = widget.data["order"];
    order.paymentMethod = PaymentMethodType.CASH.name;
    if (order.shippingAddress == null && widget.data["addresses"] != null) {
      List<ShippingAddress> listShippingAddress = widget.data["addresses"];
      var indexShippingAddress =
          listShippingAddress.indexWhere((element) => element.isDefault);
      if (indexShippingAddress >= 0) {
        order.shippingAddress = listShippingAddress[indexShippingAddress];
      } else if (listShippingAddress.length > 0) {
        order.shippingAddress = listShippingAddress.first;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) async {
        if (state is OrderLoadingState) {
          LoadingHelper.showLoading(context);
        } else if (state is ConfirmOrderSuccessState) {
          LoadingHelper.hideLoading(context);
          BlocProvider.of<CartBloc>(context).add(GetListCartEvent());
          setState(() {
            isPaymentSuccess = true;
          });
        } else if (state is ConfirmOrderErrorState) {
          LoadingHelper.hideLoading(context);
          Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (state is CreatePaymentOrderSuccessState) {
          LoadingHelper.hideLoading(context);
          await Navigator.pushNamed(context, Constants.webviewScreen,
              arguments: state.paymentUrl);
          BlocProvider.of<OrderBloc>(context)
              .add(CheckOrderEvent(orderId: order.id));
        } else if (state is CreatePaymentOrderErrorState) {
          LoadingHelper.hideLoading(context);
          Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (state is CheckOrderSuccessState) {
          LoadingHelper.hideLoading(context);
          if (state.isOrder) {
            BlocProvider.of<CartBloc>(context).add(GetListCartEvent());
            setState(() {
              isPaymentSuccess = true;
            });
          } else {
            Fluttertoast.showToast(
                msg: "Thanh toán thất bại. Vui lòng thử lại!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        } else if (state is CheckOrderErrorState) {
          LoadingHelper.hideLoading(context);
          Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (state is CancelOrderSuccessState) {
          Navigator.pop(context);
        }
      },
      child: BlocListener<ShippingAddressBloc, ShippingAddressState>(
        listener: (context, state) async {
          if (state is ShippingAddressLoadingState) {
            LoadingHelper.showLoading(context);
          } else if (state is GetListAddressSuccessState) {
            if (state.indexPage == 3) {
              LoadingHelper.hideLoading(context);
              setState(() {
                var indexShippingAddress = state.listAddress
                    .indexWhere((element) => element.isDefault);
                if (indexShippingAddress >= 0) {
                  order.shippingAddress =
                      state.listAddress[indexShippingAddress];
                } else if (state.listAddress.length > 0) {
                  order.shippingAddress = state.listAddress.first;
                }
              });
            }
          } else if (state is GetListAddressErrorState) {
            if (state.indexPage == 3) {
              LoadingHelper.hideLoading(context);
              Fluttertoast.showToast(
                  msg: state.message,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
        },
        child: WillPopScope(
          onWillPop: () async {
            if (isPaymentSuccess) {
              return false;
            }
            return true;
          },
          child: Scaffold(
            backgroundColor: AppColors.kPrimaryColor,
            body: Stack(
              children: [
                SafeArea(
                  child: Column(
                    children: [
                      AppBarTitle(appTitle: StringName.orderInformation),
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: CustomScrollBehavior(),
                          child: ListView(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 17),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 6,
                                    ),
                                    GestureDetector(
                                      onTap: handleClickAddress,
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(Icons.place),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  TextNormal(
                                                    title: StringName
                                                        .deliveryAddress,
                                                    colors:
                                                        AppColors.bPrimaryColor,
                                                    fontName: AppThemes.jaldi,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  order.shippingAddress != null
                                                      ? Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                              TextNormal(
                                                                title: order
                                                                    .shippingAddress!
                                                                    .receiver,
                                                                colors: AppColors
                                                                    .bPrimaryColor
                                                                    .withOpacity(
                                                                        0.2),
                                                                fontName:
                                                                    AppThemes
                                                                        .jaldi,
                                                                size: 14,
                                                              ),
                                                              TextNormal(
                                                                title: order
                                                                    .shippingAddress!
                                                                    .phoneNumber,
                                                                colors: AppColors
                                                                    .bPrimaryColor
                                                                    .withOpacity(
                                                                        0.2),
                                                                fontName:
                                                                    AppThemes
                                                                        .jaldi,
                                                                size: 14,
                                                              ),
                                                              TextNormal(
                                                                title: order
                                                                    .shippingAddress!
                                                                    .address,
                                                                colors: AppColors
                                                                    .bPrimaryColor
                                                                    .withOpacity(
                                                                        0.2),
                                                                fontName:
                                                                    AppThemes
                                                                        .jaldi,
                                                                size: 14,
                                                              ),
                                                            ])
                                                      : Container(
                                                          color: Colors
                                                              .transparent,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 4),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              TextNormal(
                                                                title:
                                                                    "Thêm địa chỉ mới",
                                                                colors: AppColors
                                                                    .bPrimaryColor,
                                                                fontName:
                                                                    AppThemes
                                                                        .jaldi,
                                                                size: 14,
                                                              ),
                                                              Icon(Icons.add)
                                                            ],
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            if (order.status ==
                                                OrderStatusType.PROCESSING)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 18),
                                                child: Icon(
                                                  Icons
                                                      .arrow_forward_ios_outlined,
                                                  size: 20,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: order.listOrderItem
                                          .map((e) => CardOrder(
                                                orderItem: e,
                                              ))
                                          .toList(),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextNormal(
                                          title: StringName.subtotal,
                                          colors: AppColors.bPrimaryColor,
                                          fontName: AppThemes.jaldi,
                                        ),
                                        TextNormal(
                                          title:
                                              "${Utility.formatNumberDoubleToInt(order.totalAmount)}\$",
                                          colors: AppColors.bPrimaryColor,
                                          fontName: AppThemes.jaldi,
                                        ),
                                      ],
                                    ),
                                    if (order.status ==
                                        OrderStatusType.PROCESSING)
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextNormal(
                                                title: StringName.voucher,
                                                colors: AppColors.bPrimaryColor,
                                                fontName: AppThemes.jaldi,
                                              ),
                                              Row(
                                                children: [
                                                  if (order.discount != null)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 4),
                                                      child: TextNormal(
                                                        title:
                                                            "${Utility.formatNumberDoubleToInt(calculateDiscount())}\$",
                                                        colors: AppColors
                                                            .bPrimaryColor,
                                                        fontName:
                                                            AppThemes.jaldi,
                                                      ),
                                                    ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  GestureDetector(
                                                    onTap: handleApplyDiscount,
                                                    child: Icon(
                                                      Icons
                                                          .arrow_forward_ios_outlined,
                                                      size: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    if (order.status !=
                                            OrderStatusType.PROCESSING &&
                                        order.discountAmount != null)
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextNormal(
                                                title: StringName.discount,
                                                colors: AppColors.bPrimaryColor,
                                                fontName: AppThemes.jaldi,
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 4),
                                                    child: TextNormal(
                                                      title:
                                                          "${Utility.formatNumberDoubleToInt(calculateDiscount())}\$",
                                                      colors: AppColors
                                                          .bPrimaryColor,
                                                      fontName: AppThemes.jaldi,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextNormal(
                                          title: StringName.transport,
                                          colors: AppColors.bPrimaryColor,
                                          fontName: AppThemes.jaldi,
                                        ),
                                        TextNormal(
                                          title: StringName.free,
                                          colors: AppColors.green1,
                                          fontName: AppThemes.jaldi,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextNormal(
                                          title: StringName.total,
                                          colors: AppColors.bPrimaryColor,
                                          fontName: AppThemes.jaldi,
                                          size: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        TextNormal(
                                          title:
                                              "${Utility.formatNumberDoubleToInt(total)}\$",
                                          colors: AppColors.bPrimaryColor,
                                          fontName: AppThemes.jaldi,
                                          size: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: AppColors.bPrimaryColor,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.credit_card,
                                              size: 28,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 6.0),
                                              child: TextNormal(
                                                title: StringName.paymentMethod,
                                                colors: AppColors.bPrimaryColor,
                                                fontName: AppThemes.jaldi,
                                                size: 20,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: TextNormal(
                                                title: order.paymentMethod ==
                                                        PaymentMethodType
                                                            .CASH.name
                                                    ? StringName
                                                        .paymentOnDelivery
                                                    : StringName
                                                        .paymentViaVNPay,
                                                colors: AppColors.bPrimaryColor,
                                                fontName: AppThemes.jaldi,
                                              ),
                                            ),
                                            if (order.status ==
                                                OrderStatusType.PROCESSING)
                                              GestureDetector(
                                                onTap:
                                                    handleChangePaymentMethod,
                                                child: Icon(
                                                  Icons
                                                      .arrow_forward_ios_outlined,
                                                  size: 16,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: AppColors.bPrimaryColor,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextNormal(
                                          title: StringName.codeOrders,
                                          colors: AppColors.bPrimaryColor,
                                          fontName: AppThemes.jaldi,
                                          size: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        TextNormal(
                                          title: order.codeOrder,
                                          colors: AppColors.bPrimaryColor,
                                          fontName: AppThemes.jaldi,
                                          size: 18,
                                          fontWeight: FontWeight.w700,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextNormal(
                                          title: StringName.orderDate,
                                          colors: AppColors.bPrimaryColor,
                                          fontName: AppThemes.jaldi,
                                        ),
                                        TextNormal(
                                          title: DateTimeHelper.formatDate(
                                              order.orderDate,
                                              format: DateFormat.dateHour),
                                          colors: AppColors.bPrimaryColor,
                                          fontName: AppThemes.jaldi,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextNormal(
                                          title:
                                              StringName.estimatedDeliveryTime,
                                          colors: AppColors.bPrimaryColor,
                                          fontName: AppThemes.jaldi,
                                        ),
                                        TextNormal(
                                          title: DateTimeHelper.formatDate(
                                              order.orderDate
                                                  .add(Duration(days: 3)),
                                              format: DateFormat.date),
                                          colors: AppColors.bPrimaryColor,
                                          fontName: AppThemes.jaldi,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 37,
                                    ),
                                    if (order.status ==
                                        OrderStatusType.PROCESSING)
                                      ButtonNormal(
                                        text: StringName.confirmOrder,
                                        onPressed: handleConfirmOrder,
                                      ),
                                    if (order.status == OrderStatusType.PENDING)
                                      ButtonNormal(
                                        text: StringName.cancelOrder,
                                        backgroundColor: AppColors.heroRed,
                                        textColor: AppColors.kPrimaryColor,
                                        onPressed: () => handleCancelOrder(
                                            context, order.id),
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
                if (isPaymentSuccess) paymentSuccess()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget paymentSuccess() {
    return Container(
      color: AppColors.kPrimaryColor,
      child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Lottie.asset(AppImages.paymentSuccess, height: 200, repeat: false),
          TextNormal(
            title: 'Thanh toán thành công.',
            colors: AppColors.bPrimaryColor,
            fontName: AppThemes.jaldi,
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 17),
            child: ButtonNormal(
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, Constants.dashBoardScreen);
              },
              text: 'Về trang chủ',
            ),
          ),
        ],
      ),
    );
  }

  handleChangePaymentMethod() async {
    var result = await Navigator.pushNamed(
        context, Constants.paymentMethodScreen,
        arguments: order.paymentMethod);
    if (result != null) {
      order.paymentMethod = result as String;
      setState(() {});
    }
  }

  handleConfirmOrder() {
    if (order.shippingAddress == null) {
      Fluttertoast.showToast(
          msg: "Chưa chọn địa chỉ giao hàng",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    if (order.paymentMethod == null) {
      Fluttertoast.showToast(
          msg: "Chưa chọn phương thức thanh toán",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    if (order.paymentMethod == PaymentMethodType.CASH.name) {
      BlocProvider.of<OrderBloc>(context).add(ConfirmOrderEvent(
          orderId: order.id,
          paymentMethod: order.paymentMethod!,
          shippingAddressId: order.shippingAddress!.id,
          discountId: order.discount?.id));
    } else {
      BlocProvider.of<OrderBloc>(context).add(CreatePaymentOrderEvent(
          orderId: order.id,
          shippingAddressId: order.shippingAddress!.id,
          discountId: order.discount?.id));
    }
  }

  handleApplyDiscount() async {
    var result = await Navigator.pushNamed(
        context, Constants.applyDiscountScreen,
        arguments: order.discount);
    if (result != null) {
      if (result != false) {
        order.discount = result as Discount;
      } else {
        order.discount = null;
      }
      setState(() {});
    }
  }

  handleClickAddress() async {
    if (order.shippingAddress != null) {
      var result =
          await Navigator.pushNamed(context, Constants.shippingAddressScreen);
      if (result != null) {
        if (result != false) {
          order.shippingAddress = result as ShippingAddress;
        } else {
          order.shippingAddress = null;
        }
        setState(() {});
      }
    } else {
      var result = await Navigator.pushNamed(
          context, Constants.newShippingAddressScreen);
      if (result != null) {
        BlocProvider.of<ShippingAddressBloc>(context)
            .add(GetListAddressEvent(indexPage: 3));
      }
    }
  }

  handleCancelOrder(BuildContext context, String orderId) async {
    var result = await DialogHelper.showDialogWidget(
        context: context, widget: DialogCancelOrder());
    if (result != null) {
      BlocProvider.of<OrderBloc>(context)
          .add(CancelOrderEvent(orderId: orderId, reason: result));
    }
  }
}
