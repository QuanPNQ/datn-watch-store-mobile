import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/models/models.dart';

class Order {
  final String id;
  final String codeOrder;
  final List<OrderItem> listOrderItem;
  ShippingAddress? shippingAddress;
  Discount? discount;
  final String status;
  String? paymentMethod;
  final DateTime orderDate;
  final DateTime estDeliveryDate;

  Order({
    required this.id,
    required this.codeOrder,
    required this.listOrderItem,
    this.shippingAddress,
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
        estDeliveryDate:
            DateTime.parse(json['estDeliveryDate'].toString()).toLocal(),
        status: json['status'],
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
