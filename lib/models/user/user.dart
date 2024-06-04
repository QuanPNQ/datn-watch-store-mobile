class User {
  final String id;
  final String name;
  final String? phone;
  final String? avatarUrl;

  User({required this.id, required this.name, this.phone, this.avatarUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'phone': phone,
      };
}
