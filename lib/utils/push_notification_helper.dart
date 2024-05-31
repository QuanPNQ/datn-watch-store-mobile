import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_mob/models/push_notification.dart';

class PushNotificationHelper {
  static Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
  }

  static Future<String?> getFireBaseToken() async {
    return FirebaseMessaging.instance.getToken();
  }

  static Future<String> getOs() async {
    return Platform.operatingSystem;
  }

  static Future<PushNotification> getPushNotification() async {
    String deviceId = "";
    String os = "";
    String fBaseToken = "";

    await getDeviceId().then((value) => deviceId = value!);
    await getOs().then((value) => os = value);
    await getFireBaseToken().then((value) => fBaseToken = value!);

    final pushNotification =
        PushNotification(token: fBaseToken, deviceId: deviceId, os: os);

    return await pushNotification;
  }
}
