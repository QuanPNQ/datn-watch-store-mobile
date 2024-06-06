import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/models/models.dart';

class Order {
  final String id;
  final String codeOrder;
  final List<OrderItem> listWatch;
  final ShippingAddress? shippingAddress;
  final Discount? discount;
  final OrderStatusType status;
  final PaymentMethodType? paymentMethod;
  final DateTime orderDate;

  const Order({
    required this.id,
    required this.codeOrder,
    required this.listWatch,
    this.shippingAddress,
    this.discount,
    required this.status,
    required this.orderDate,
    this.paymentMethod,
  });
}
