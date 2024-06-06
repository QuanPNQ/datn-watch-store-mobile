import 'package:flutter_mob/configs/constants.dart';

class Discount {
  final String id;
  final String code;
  final String content;
  final DateTime createdDate;
  final DateTime expirationDate;
  final DateTime discountType;
  final DiscountType discountValue;

  Discount({
    required this.id,
    required this.code,
    required this.content,
    required this.createdDate,
    required this.expirationDate,
    required this.discountType,
    required this.discountValue,
  });
}
