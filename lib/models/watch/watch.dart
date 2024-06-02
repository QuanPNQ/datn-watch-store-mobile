class Watch {
  final String id;
  final String brandId;
  final String name;
  final String description;
  final int quantity;
  final double price;
  final List<String> photoUrls;
  final DateTime createdDate;
  final double size;
  final String? machineCategory;
  final String? wireCategory;

  const Watch({
    required this.id,
    required this.brandId,
    required this.name,
    required this.description,
    required this.quantity,
    required this.price,
    required this.photoUrls,
    required this.createdDate,
    required this.size,
    this.machineCategory,
    this.wireCategory,
  });
}
