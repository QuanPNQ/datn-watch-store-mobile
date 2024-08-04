import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mob/exception/unauthorized_exception.dart';
import 'package:flutter_mob/service/base_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_mob/configs/constants.dart';

class NotifyService extends BaseService {
  Future<dynamic> getListNotify() async {
    String uri = "${Constants.baseUrl}notify";
    debugPrint("[NotifyService] getListNotify uri: $uri");

    final response =
        await http.get(Uri.parse(uri), headers: await requestTokenHeader());

    debugPrint("[NotifyService] getListNotify res  ${response.body}");
    if (response.statusCode == HttpStatus.unauthorized) {
      throw UnauthorizedException();
    }
    return response;
  }

  Future<dynamic> readNotify(String notifyId) async {
    String uri = "${Constants.baseUrl}notify/$notifyId";
    debugPrint("[NotifyService] readNotify uri: $uri");

    final response =
        await http.put(Uri.parse(uri), headers: await requestTokenHeader());

    debugPrint("[NotifyService] readNotify res  ${response.body}");
    if (response.statusCode == HttpStatus.unauthorized) {
      throw UnauthorizedException();
    }
    return response;
  }
}
