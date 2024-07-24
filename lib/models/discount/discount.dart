import 'package:flutter_mob/configs/constants.dart';

class Discount {
  final String id;
  final String code;
  final String content;
  final DateTime createdDate;
  final DateTime? expirationDate;
  final String discountType;
  final double discountValue;

  Discount({
    required this.id,
    required this.code,
    required this.content,
    required this.createdDate,
    this.expirationDate,
    required this.discountType,
    required this.discountValue,
  });

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
        id: json['_id'],
        code: json['code'],
        content: json['content'],
        createdDate: DateTime.parse(json['createdDate'].toString()).toLocal(),
        expirationDate: json['expirationDate'] != null
            ? DateTime.parse(json['expirationDate'].toString()).toLocal()
            : null,
        discountType: json['discountType'],
        discountValue: double.parse(json['discountValue'].toString()),
      );
}
