import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_mob/app.dart';
import 'package:flutter_mob/blocs/authentication/auth_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mob/repositories/authentication/auth_repository.dart';
import 'storage/sharedpreferences/shared_preferences_manager.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    playSound: true);

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handle background message ${message.messageId}');
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidInitializationSettings _androidInitializationSettings =
    AndroidInitializationSettings('mipmap/ic_launcher');

const DarwinInitializationSettings _darwinInitializationSettings =
    DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true);

Future<void> fCMSetup() async {
  await Firebase.initializeApp();

  FirebaseMessaging.instance
      .getToken()
      .then((value) => {debugPrint('fireBaseToken: $value')});

  FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((event) async {
    try {
      debugPrint("message received");
      print(event.notification);
      debugPrint(event.notification?.body);
      debugPrint(event.notification?.title);
      AndroidNotificationDetails androidNotificationDetails =
          const AndroidNotificationDetails('channelId', 'channelName',
              importance: Importance.max, priority: Priority.high);

      DarwinNotificationDetails darwinNotificationDetails =
          DarwinNotificationDetails();

      NotificationDetails notificationDetails = NotificationDetails(
          android: androidNotificationDetails, iOS: darwinNotificationDetails);
      await flutterLocalNotificationsPlugin.show(0, event.notification?.title,
          event.notification?.body, notificationDetails);
    } catch (e) {
      debugPrint(e.toString());
    }
  });

  FirebaseMessaging.instance.getInitialMessage().then((event) {
    try {} catch (e) {
      debugPrint(e.toString());
    }
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  InitializationSettings initializationSettings = const InitializationSettings(
      android: _androidInitializationSettings,
      iOS: _darwinInitializationSettings);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await SharedPrefManager().init();
  await Firebase.initializeApp();
  await fCMSetup();

  runZonedGuarded(() {
    runApp(MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) => AuthBloc(authRepository: AuthRepository())),
    ], child: const App()));
  }, (error, stackTrace) {});
}
