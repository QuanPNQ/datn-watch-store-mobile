import 'package:equatable/equatable.dart';

class PushNotification extends Equatable {
  final String token;
  final String deviceId;
  final String os;

  const PushNotification({
    required this.token,
    required this.deviceId,
    required this.os
  });

  factory PushNotification.fromJson(Map<String, dynamic> json) =>
      PushNotification(
        token: json['token'],
        deviceId: json['deviceId'],
        os: json['os']
  );

  Map<String, dynamic> toJson() => {
    'token': token,
    'deviceId': deviceId,
    'os': os
  };

  @override
  List<Object?> get props => [
    token,
    deviceId,
    os
  ];

}