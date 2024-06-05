import 'package:flutter_mob/models/cart/cart_item.dart';

class Cart {
  final String id;
  final List<CartItem> listWatch;

  const Cart({
    required this.id,
    required this.listWatch,
  });
}
