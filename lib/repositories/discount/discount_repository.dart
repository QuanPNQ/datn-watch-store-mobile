import 'package:flutter_mob/service/discount_service.dart';

class DiscountRepository {
  Future<dynamic> getListDiscount() async {
    return await DiscountService().getListDiscount();
  }
}
