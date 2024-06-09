class Account {
  final String id;
  final String userName;
  final String email;
  final String phoneNumber;
  final String? avatarUrl;
  final String? name;

  Account(
      {required this.id,
      required this.userName,
      required this.email,
      required this.phoneNumber,
      this.avatarUrl,
      this.name});
}
