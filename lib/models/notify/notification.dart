class Notification {
  final String id;
  final String title;
  final String message;
  final DateTime createdAt;
  final String type;
  final bool isRead;

  Notification({
    required this.id,
    required this.title,
    required this.message,
    required this.createdAt,
    required this.type,
    required this.isRead,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json['notificationId'],
        title: json['title'],
        message: json['message'],
        createdAt: DateTime.parse(json['createdAt'].toString()).toLocal(),
        type: json['type'],
        isRead: json['isRead'],
      );
}
