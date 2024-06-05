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
}
