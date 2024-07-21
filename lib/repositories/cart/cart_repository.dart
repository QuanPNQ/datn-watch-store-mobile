import 'package:flutter_mob/service/cart_service.dart';

class CartRepository {
  Future<dynamic> getListCart() async {
    return await CartService().getListCart();
  }
}
