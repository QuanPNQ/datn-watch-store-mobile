class Brand {
  final String id;
  final String name;
  final String description;
  final String logo;

  const Brand({
    required this.id,
    required this.name,
    required this.description,
    required this.logo,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      logo: json['logo']);
}
