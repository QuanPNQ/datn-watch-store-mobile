import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/utils/push_notification_helper.dart';

class AuthService {
  Future<dynamic> login(
      {required String email, required String password}) async {
    String deviceId = "";
    String token = "";
    String os = "";

    await PushNotificationHelper.getDeviceId()
        .then((value) => deviceId = value!);
    await PushNotificationHelper.getFireBaseToken()
        .then((value) => token = value!);
    await PushNotificationHelper.getOs().then((value) => os = value);
    final response = await http.post(Uri.parse("${Constants.baseUrl}login"),
        headers: Constants.requestHeaders,
        body: jsonEncode({
          "email": email,
          "password": password,
          "deviceId": deviceId,
          "token": token,
          "os": os
        }));
    return response;
  }
}
