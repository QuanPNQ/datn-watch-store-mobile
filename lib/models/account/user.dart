class Account {
  final String? id;
  final String userName;
  final String email;
  final String phoneNumber;
  final String? avatarUrl;
  final String? name;
  final String? password;

  Account(
      {this.id,
      required this.userName,
      required this.email,
      required this.phoneNumber,
      this.avatarUrl,
      this.name,
      this.password});

  factory Account.fromJson(Map<String, dynamic> json) => Account(
      id: json['_id'],
      userName: json['userName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'].toString(),
      avatarUrl: json['avatarUrl'],
      name: json['name']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      "userName": userName,
      "email": email,
      "phoneNumber": phoneNumber,
      "name": name,
    };
    if (id != null) {
      json['_id'] = id;
    }
    if (avatarUrl != null) {
      json['avatarUrl'] = avatarUrl;
    }
    return json;
  }

  Map<String, dynamic> toSignupJson() => {
        "userName": userName,
        "email": email,
        "phoneNumber": phoneNumber,
        "name": name,
        "password": password
      };
}
