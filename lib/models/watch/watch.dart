import 'package:flutter_mob/models/brand/brand.dart';
import 'package:flutter_mob/models/models.dart';

class Watch {
  final String id;
  final Brand? brand;
  final String name;
  final String description;
  final int quantity;
  final int numberPurchase;
  final int totalSold;
  final double price;
  final List<String> photoUrls;
  final DateTime createdDate;
  final double size;
  final String? machineCategory;
  final String? wireCategory;
  final List<Review> listReview;

  const Watch({
    required this.id,
    required this.brand,
    required this.name,
    required this.description,
    required this.quantity,
    required this.numberPurchase,
    required this.totalSold,
    required this.price,
    required this.photoUrls,
    required this.createdDate,
    required this.size,
    this.machineCategory,
    this.wireCategory,
    required this.listReview,
  });

  factory Watch.fromJson(Map<String, dynamic> json) => Watch(
      id: json['_id'],
      brand: json['brand'] != null ? Brand.fromJson(json['brand']) : null,
      name: json['name'],
      description: json['description'],
      price: double.parse(json['price'].toString()),
      quantity: int.parse(json['price'].toString()),
      photoUrls: List.from(json['photoUrls'].map((e) => e)),
      createdDate: DateTime.parse(json['createdDate']),
      size: double.parse(json['size'].toString()),
      machineCategory: json['machineCategory'],
      wireCategory: json['wireCategory'],
      numberPurchase: json['numberPurchase'] != null
          ? int.parse(json['numberPurchase'].toString())
          : 0,
      totalSold: json['totalSold'] != null
          ? int.parse(json['totalSold'].toString())
          : 0,
      listReview: json['reviews'] != null
          ? List.from(json['reviews'].map((e) => Review.fromJson(e)))
          : []);
}
