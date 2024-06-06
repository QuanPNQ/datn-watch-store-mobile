import 'package:flutter/material.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/order/order.dart';
import 'package:flutter_mob/models/shipping_address/shipping_address.dart';
import 'package:flutter_mob/ui/components/app_bar/app_bar_title.dart';
import 'package:flutter_mob/ui/components/button/button_normal.dart';
import 'package:flutter_mob/ui/components/card/card_order.dart';
import 'package:flutter_mob/ui/components/scroll_behavior/scroll_behavior.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:flutter_mob/utils/date_time_helper.dart';
import 'package:flutter_mob/utils/utility.dart';

class DetailOrderScreen extends StatefulWidget {
  const DetailOrderScreen({super.key});

  @override
  State<DetailOrderScreen> createState() => _DetailOrderScreenState();
}

class _DetailOrderScreenState extends State<DetailOrderScreen> {
  ShippingAddress? shippingAddress = Constants.mockDataShippingAddress;
  Order order = Constants.mockDataOrder;
  double discountPercent = 0.03;

  double get subtotal => order.listWatch.fold(
        0.0,
        (previousValue, item) =>
            previousValue + (item.watch.price * item.quantity),
      );

  double get discount => (discountPercent * subtotal).toInt().toDouble();

  double get total => subtotal - discount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            AppBarTitle(appTitle: StringName.orderInformation),
            Expanded(
              child: ScrollConfiguration(
                behavior: CustomScrollBehavior(),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.place),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 6,
                                    ),
                                    TextNormal(
                                      title: StringName.deliveryAddress,
                                      colors: AppColors.bPrimaryColor,
                                      fontName: AppThemes.jaldi,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    TextNormal(
                                      title: shippingAddress!.receiver,
                                      colors: AppColors.bPrimaryColor
                                          .withOpacity(0.2),
                                      fontName: AppThemes.jaldi,
                                      size: 14,
                                    ),
                                    TextNormal(
                                      title: shippingAddress!.phoneNumber,
                                      colors: AppColors.bPrimaryColor
                                          .withOpacity(0.2),
                                      fontName: AppThemes.jaldi,
                                      size: 14,
                                    ),
                                    TextNormal(
                                      title: shippingAddress!.address,
                                      colors: AppColors.bPrimaryColor
                                          .withOpacity(0.2),
                                      fontName: AppThemes.jaldi,
                                      size: 14,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 18),
                                child: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: order.listWatch
                                .map((e) => CardOrder(
                                      orderItem: e,
                                    ))
                                .toList(),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextNormal(
                                title: StringName.subtotal,
                                colors: AppColors.bPrimaryColor,
                                fontName: AppThemes.jaldi,
                              ),
                              TextNormal(
                                title:
                                    "${Utility.formatNumberDoubleToInt(subtotal)}\$",
                                colors: AppColors.bPrimaryColor,
                                fontName: AppThemes.jaldi,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextNormal(
                                title: StringName.voucher,
                                colors: AppColors.bPrimaryColor,
                                fontName: AppThemes.jaldi,
                              ),
                              TextNormal(
                                title:
                                    "${Utility.formatNumberDoubleToInt(discount)}\$",
                                colors: AppColors.bPrimaryColor,
                                fontName: AppThemes.jaldi,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                    padding: const EdgeInsets.only(top: 6.0),
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
                              TextNormal(
                                title: StringName.paymentOnDelivery,
                                colors: AppColors.bPrimaryColor,
                                fontName: AppThemes.jaldi,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextNormal(
                                title: StringName.estimatedDeliveryTime,
                                colors: AppColors.bPrimaryColor,
                                fontName: AppThemes.jaldi,
                              ),
                              TextNormal(
                                title: DateTimeHelper.formatDate(
                                    order.orderDate.add(Duration(days: 3)),
                                    format: DateFormat.date),
                                colors: AppColors.bPrimaryColor,
                                fontName: AppThemes.jaldi,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 37,
                          ),
                          ButtonNormal(
                            text: StringName.confirmOrder,
                            onPressed: handleConfirmOrder,
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

  handleConfirmOrder() {}
}
