import 'package:flutter_mob/models/account/account.dart';

class Review {
  final String id;
  final Account account;
  final String comment;
  final DateTime date;
  final List<String> photoUrls;
  final double rate;

  const Review(
      {required this.id,
      required this.account,
      required this.comment,
      required this.date,
      required this.photoUrls,
      required this.rate});

  factory Review.fromJson(Map<String, dynamic> json) => Review(
      id: json['_id'],
      account: Account.fromJson(json['account']),
      comment: json['comment'],
      date: DateTime.parse(json['date']),
      photoUrls: List.from(json['photoUrls'].map((e) => e.toString())),
      rate: double.parse(json['rate'].toString()));
}
