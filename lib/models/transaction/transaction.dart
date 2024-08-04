class Transaction {
  final String id;
  final double amount;
  final DateTime createdAt;
  final String content;

  Transaction({
    required this.id,
    required this.amount,
    required this.createdAt,
    required this.content,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json['_id'],
        amount: double.parse(json['amount'].toString()),
        createdAt: DateTime.parse(json['createdAt'].toString()).toLocal(),
        content: json['content'],
      );
}
