import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mob/exception/unauthorized_exception.dart';
import 'package:flutter_mob/service/base_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_mob/configs/constants.dart';

class SearchHistoriesService extends BaseService {
  Future<dynamic> getListSearchHistories() async {
    String uri = "${Constants.baseUrl}search-histories";
    debugPrint("[SearchHistoriesService] getListSearchHistories uri: $uri");

    final response =
        await http.get(Uri.parse(uri), headers: await requestTokenHeader());

    debugPrint(
        "[SearchHistoriesService] getListSearchHistories res  ${response.body}");
    if (response.statusCode == HttpStatus.unauthorized) {
      throw UnauthorizedException();
    }
    return response;
  }
}
