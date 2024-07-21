import 'package:flutter_mob/models/watch/watch.dart';

class CartItem {
  final String id;
  final Watch watch;
  int quantity;

  CartItem({
    required this.id,
    required this.watch,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
      id: json['_id'],
      watch: Watch.fromJson(json['product']),
      quantity: json['quantity']);
}
