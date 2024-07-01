import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mob/models/account/account.dart';
import 'package:flutter_mob/service/base_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/utils/push_notification_helper.dart';

class AuthService extends BaseService {
  Future<dynamic> login(
      {required String userName, required String password}) async {
    String deviceId = "";
    String token = "";
    String os = "";

    await PushNotificationHelper.getDeviceId()
        .then((value) => deviceId = value!);
    await PushNotificationHelper.getFireBaseToken()
        .then((value) => token = value!);
    await PushNotificationHelper.getOs().then((value) => os = value);

    String uri = "${Constants.baseUrl}auth/login";
    var body = {
      "userName": userName,
      "password": password,
      "firebase": {"deviceId": deviceId, "token": token, "osPlatform": os},
    };

    debugPrint("[AuthService] login uri: $uri");
    debugPrint("[AuthService] login body: $body");

    final response = await http.post(Uri.parse(uri),
        headers: Constants.requestHeaders, body: jsonEncode(body));
    log("[AuthService] login response: ${response.body}");
    return response;
  }

  Future<dynamic> signup({required Account account}) async {
    String uri = "${Constants.baseUrl}auth/register";
    debugPrint("[AuthService] signup uri: $uri");
    debugPrint("[AuthService] signup body: ${account.toSignupJson()}");

    final response = await http.post(Uri.parse(uri),
        headers: Constants.requestHeaders,
        body: jsonEncode(account.toSignupJson()));

    debugPrint("[AuthService] signup response: ${response.body}");
    return response;
  }

  Future<dynamic> logout() async {
    String deviceId = "";
    await PushNotificationHelper.getDeviceId()
        .then((value) => deviceId = value!);

    var body = {
      "deviceId": deviceId,
    };

    String uri = "${Constants.baseUrl}auth/logout";
    debugPrint("[AuthService] logout uri: $uri");
    debugPrint("[AuthService] logout body: ${body}");

    final response = await http.post(Uri.parse(uri),
        headers: await requestTokenHeader(), body: jsonEncode(body));

    debugPrint("[AuthService] logout response: ${response.body}");
    return response;
  }
}
