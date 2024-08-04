import 'package:flutter_mob/service/order_service.dart';

class OrderRepository {
  Future<dynamic> processOrder() async {
    return await OrderService().processOrder();
  }

  Future<dynamic> confirmOrder({
    required String orderId,
    required String shippingAddressId,
    required String paymentMethod,
    String? discountId,
  }) async {
    return await OrderService().confirmOrder(
        orderId: orderId,
        shippingAddressId: shippingAddressId,
        paymentMethod: paymentMethod,
        discountId: discountId);
  }

  Future<dynamic> createPaymentOrder({
    required String orderId,
    required String shippingAddressId,
    String? discountId,
  }) async {
    return await OrderService().createPaymentOrder(
        orderId: orderId,
        shippingAddressId: shippingAddressId,
        discountId: discountId);
  }

  Future<dynamic> checkOrder({
    required String orderId,
  }) async {
    return await OrderService().checkOrder(
      orderId: orderId,
    );
  }

  Future<dynamic> getListOrder({
    String? status,
  }) async {
    return await OrderService().getListOrder(
      status: status,
    );
  }

  Future<dynamic> cancelOrder({
    required String orderId,
    required String reason,
  }) async {
    return await OrderService().cancelOrder(orderId: orderId, reason: reason);
  }
}
