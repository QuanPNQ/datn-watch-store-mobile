import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class MyConnectivity {
  MyConnectivity._();

  static final _instance = MyConnectivity._();
  static MyConnectivity get instance => _instance;
  final _connectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;

  Future<void> initialise() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    checkStatus(result);
    _connectivity.onConnectivityChanged.listen((result) {
      checkStatus(result);
    });
  }

  void checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      await Future.delayed(const Duration(seconds: 1));
      final result = await InternetAddress.lookup('example.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }

  void disposeStream() => _controller.close();
}