class ShippingAddress {
  final String id;
  final String title;
  final String receiver;
  final String address;
  final String phoneNumber;
  final bool isDefault;

  ShippingAddress(
      {required this.id,
      required this.title,
      required this.receiver,
      required this.address,
      required this.phoneNumber,
      required this.isDefault});
}
