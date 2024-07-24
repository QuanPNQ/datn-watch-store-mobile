class ShippingAddress {
  final String id;
  final String? title;
  final String receiver;
  final String address;
  final String phoneNumber;
  bool isDefault;

  ShippingAddress(
      {required this.id,
      this.title,
      required this.receiver,
      required this.address,
      required this.phoneNumber,
      required this.isDefault});

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        id: json['_id'],
        title: json['title'],
        receiver: json['receiver'],
        address: json['address'],
        phoneNumber: json['phoneNumber'],
        isDefault: json['isDefault'] ?? false,
      );
}
