import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/order/order_bloc.dart';
import 'package:flutter_mob/blocs/order/order_event.dart';
import 'package:flutter_mob/blocs/product/product_bloc.dart';
import 'package:flutter_mob/blocs/product/product_event.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/configs/themes.dart';
import 'package:flutter_mob/models/models.dart';
import 'package:flutter_mob/ui/components/button/button_normal.dart';
import 'package:flutter_mob/ui/components/dialog/dialog_cancel_order.dart';
import 'package:flutter_mob/ui/components/dialog/dialog_evaluate_product.dart';
import 'package:flutter_mob/ui/components/text/text_normal.dart';
import 'package:flutter_mob/utils/dialog_helper.dart';
import 'package:flutter_mob/utils/utility.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardOrderVerify extends StatelessWidget {
  final Order order;
  final String accountId;
  final Function() onClick;

  const CardOrderVerify({
    super.key,
    required this.order,
    required this.accountId,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    double total = order.totalAmount - (order.discountAmount ?? 0);

    checkEvaluated(String productId) {
      var existedOrderItem = order.listOrderItem
          .indexWhere((element) => element.watch.id == productId);
      if (existedOrderItem >= 0) {
        var existedReview = order
            .listOrderItem[existedOrderItem].watch.listReview
            .indexWhere((element) => element.account.id == accountId);
        if (existedReview >= 0) return true;
      }
      return false;
    }

    return GestureDetector(
      onTap: onClick,
      child: Padding(
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
              ...order.listOrderItem.map((e) {
                return Container(
                  height: order.status == OrderStatusType.DELIVERED ? 102 : 64,
                  padding: EdgeInsets.only(left: 12),
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: AppColors.grey4),
                  )),
                  child: Column(
                    children: [
                      Expanded(
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
                      ),
                      if (order.status == OrderStatusType.DELIVERED)
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ButtonNormal(
                                  text: checkEvaluated(e.watch.id)
                                      ? StringName.evaluated
                                      : StringName.evaluate,
                                  width: 150,
                                  height: 30,
                                  radius: 6,
                                  enabled: !checkEvaluated(e.watch.id),
                                  onPressed: () => handleEvaluateOrder(
                                      context, order.id, e.watch.id),
                                ),
                                SizedBox(
                                  width: 12,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            )
                          ],
                        ),
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
                      title: StringName.total,
                      colors: AppColors.bPrimaryColor,
                      fontName: AppThemes.specialElite,
                      size: 14,
                    ),
                    TextNormal(
                      title:
                          "${Utility.formatNumberDoubleToInt(order.totalAmount)}\$",
                      colors: AppColors.bPrimaryColor,
                      fontName: AppThemes.specialElite,
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
              if (order.discountAmount != null)
                Column(
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
                            title: StringName.discount,
                            colors: AppColors.bPrimaryColor,
                            fontName: AppThemes.specialElite,
                            size: 14,
                          ),
                          TextNormal(
                            title:
                                "${Utility.formatNumberDoubleToInt(order.discountAmount!)}\$",
                            colors: AppColors.bPrimaryColor,
                            fontName: AppThemes.specialElite,
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
                  ],
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
                      title: "${order.listOrderItem.length} sản phẩm",
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
              if (order.status == OrderStatusType.PENDING)
                Column(
                  children: [
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.grey4,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ButtonNormal(
                          text: StringName.cancelOrder,
                          width: 150,
                          height: 35,
                          radius: 6,
                          backgroundColor: AppColors.heroRed,
                          textColor: AppColors.kPrimaryColor,
                          onPressed: () => handleCancelOrder(context, order.id),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              if (order.status == OrderStatusType.CANCELLED &&
                  order.cancelReason != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextNormal(
                            title: StringName.reason,
                            colors: AppColors.bPrimaryColor,
                            fontName: AppThemes.specialElite,
                            size: 14,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          TextNormal(
                            title: order.cancelReason!,
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
            ],
          ),
        ),
      ),
    );
  }

  handleCancelOrder(BuildContext context, String orderId) async {
    var result = await DialogHelper.showDialogWidget(
        context: context, widget: DialogCancelOrder());
    if (result != null) {
      BlocProvider.of<OrderBloc>(context)
          .add(CancelOrderEvent(orderId: orderId, reason: result));
    }
  }

  handleEvaluateOrder(
      BuildContext context, String orderId, String productId) async {
    var result = await DialogHelper.showDialogWidget(
        context: context, widget: DialogEvaluateProduct());
    if (result != null) {
      BlocProvider.of<ProductBloc>(context).add(EvaluateProductEvent(
          orderId: orderId,
          productId: productId,
          comment: result["comment"],
          rate: result["rate"]));
    }
  }
}
