import 'package:flutter_mob/service/notify_service.dart';

class NotifyRepository {
  Future<dynamic> getListNotify() async {
    return await NotifyService().getListNotify();
  }

  Future<dynamic> readNotify(String notifyId) async {
    return await NotifyService().readNotify(notifyId);
  }
}
