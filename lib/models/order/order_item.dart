import 'package:flutter_mob/models/watch/watch.dart';

class OrderItem {
  final String id;
  final Watch watch;
  int quantity;

  OrderItem({
    required this.id,
    required this.watch,
    required this.quantity,
  });
}
