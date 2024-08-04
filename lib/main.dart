import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_mob/app.dart';
import 'package:flutter_mob/blocs/account/account_bloc.dart';
import 'package:flutter_mob/blocs/authentication/auth_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mob/blocs/authentication/auth_event.dart';
import 'package:flutter_mob/blocs/brand/brand_bloc.dart';
import 'package:flutter_mob/blocs/cart/cart_bloc.dart';
import 'package:flutter_mob/blocs/discount/discount_bloc.dart';
import 'package:flutter_mob/blocs/login/login_bloc.dart';
import 'package:flutter_mob/blocs/notify/notify_bloc.dart';
import 'package:flutter_mob/blocs/notify/notify_event.dart';
import 'package:flutter_mob/blocs/order/order_bloc.dart';
import 'package:flutter_mob/blocs/product/product_bloc.dart';
import 'package:flutter_mob/blocs/search_histories/search_histories_bloc.dart';
import 'package:flutter_mob/blocs/shipping_address/shipping_address_bloc.dart';
import 'package:flutter_mob/blocs/signup/signup_bloc.dart';
import 'package:flutter_mob/blocs/transaction_histories/transaction_histories_bloc.dart';
import 'package:flutter_mob/repositories/account/account_repository.dart';
import 'package:flutter_mob/repositories/authentication/auth_repository.dart';
import 'package:flutter_mob/repositories/brand/brand_repository.dart';
import 'package:flutter_mob/repositories/cart/cart_repository.dart';
import 'package:flutter_mob/repositories/discount/discount_repository.dart';
import 'package:flutter_mob/repositories/notify/notify_repository.dart';
import 'package:flutter_mob/repositories/order/order_repository.dart';
import 'package:flutter_mob/repositories/product/product_repository.dart';
import 'package:flutter_mob/repositories/search_histories/search_histories_repository.dart';
import 'package:flutter_mob/repositories/shippingAddress/shipping_address_repository.dart';
import 'package:flutter_mob/repositories/transaction_histories/transaction_histories_repository.dart';
import 'package:flutter_mob/utils/time_ago_helper.dart';
import 'storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:timeago/timeago.dart' as timeago;

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

Future<void> fCMSetup(BuildContext context) async {
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
      BlocProvider.of<NotifyBloc>(context).add(GetListNotifyEvent());
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
  timeago.setLocaleMessages('vi', TimeAgoHelper());

  runZonedGuarded(() {
    runApp(MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) => AuthBloc(authRepository: AuthRepository())
            ..add(AppLoadedEvent())),
      BlocProvider(
          create: (context) => LoginBloc(authRepository: AuthRepository())),
      BlocProvider(
          create: (context) => SignupBloc(authRepository: AuthRepository())),
      BlocProvider(
          create: (context) =>
              ProductBloc(productRepository: ProductRepository())),
      BlocProvider(
          create: (context) => BrandBloc(brandRepository: BrandRepository())),
      BlocProvider(
          create: (context) => CartBloc(cartRepository: CartRepository())),
      BlocProvider(
          create: (context) => OrderBloc(orderRepository: OrderRepository())),
      BlocProvider(
          create: (context) => ShippingAddressBloc(
              shippingAddressRepository: ShippingAddressRepository())),
      BlocProvider(
          create: (context) =>
              DiscountBloc(discountRepository: DiscountRepository())),
      BlocProvider(
          create: (context) =>
              AccountBloc(accountRepository: AccountRepository())),
      BlocProvider(
          create: (context) =>
              NotifyBloc(notifyRepository: NotifyRepository())),
      BlocProvider(
          create: (context) => SearchHistoriesBloc(
              searchHistoriesRepository: SearchHistoriesRepository())),
      BlocProvider(
          create: (context) => TransactionHistoriesBloc(
              transactionHistoriesRepository:
                  TransactionHistoriesRepository())),
    ], child: const App()));
  }, (error, stackTrace) {});
}
