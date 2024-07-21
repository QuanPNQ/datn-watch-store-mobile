import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mob/exception/unauthorized_exception.dart';
import 'package:flutter_mob/service/base_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_mob/configs/constants.dart';

class CartService extends BaseService {
  Future<dynamic> getListCart() async {
    String uri = "${Constants.baseUrl}cart";
    debugPrint("[CartService] getListCart uri: $uri");

    final response =
        await http.get(Uri.parse(uri), headers: await requestTokenHeader());

    debugPrint("[ProductService] getListCart res  ${response.body}");
    if (response.statusCode == HttpStatus.unauthorized) {
      throw UnauthorizedException();
    }
    return response;
  }
}
