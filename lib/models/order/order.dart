import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/models/models.dart';

class Order {
  final String id;
  final String codeOrder;
  final List<OrderItem> listOrderItem;
  ShippingAddress? shippingAddress;
  Discount? discount;
  final String status;
  final double totalAmount;
  final double? discountAmount;
  String? paymentMethod;
  final DateTime orderDate;
  final DateTime estDeliveryDate;
  final DateTime? cancelDate;
  final String? cancelReason;

  Order({
    required this.id,
    required this.codeOrder,
    required this.listOrderItem,
    required this.totalAmount,
    this.discountAmount,
    this.shippingAddress,
    this.cancelDate,
    this.cancelReason,
    this.discount,
    required this.status,
    required this.orderDate,
    required this.estDeliveryDate,
    this.paymentMethod,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['_id'],
        codeOrder: json['code'],
        orderDate: DateTime.parse(json['orderDate'].toString()).toLocal(),
        cancelDate: json['cancelDate'] != null
            ? DateTime.parse(json['cancelDate'].toString()).toLocal()
            : null,
        cancelReason: json['cancelReason'],
        estDeliveryDate:
            DateTime.parse(json['estDeliveryDate'].toString()).toLocal(),
        status: json['status'],
        totalAmount: double.parse(json['totalAmount'].toString()),
        discountAmount: json['discountAmount'] != null
            ? double.parse(json['discountAmount'].toString())
            : null,
        shippingAddress: json['shippingAddress'] != null
            ? ShippingAddress.fromJson(json['shippingAddress'])
            : null,
        discount: json['discount'] != null
            ? Discount.fromJson(json['discount'])
            : null,
        paymentMethod: json['paymentMethod'],
        listOrderItem:
            List.from(json['orderItems'].map((e) => OrderItem.fromJson(e))),
      );
}
