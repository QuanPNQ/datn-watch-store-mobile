import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mob/exception/unauthorized_exception.dart';
import 'package:flutter_mob/service/base_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_mob/configs/constants.dart';

class TransactionHistoriesService extends BaseService {
  Future<dynamic> getListTransactionHistories() async {
    String uri = "${Constants.baseUrl}transaction-histories";
    debugPrint("[TransactionHistoriesService] getListTransactionHistories uri: $uri");

    final response =
        await http.get(Uri.parse(uri), headers: await requestTokenHeader());

    debugPrint(
        "[TransactionHistoriesService] getListTransactionHistories res  ${response.body}");
    if (response.statusCode == HttpStatus.unauthorized) {
      throw UnauthorizedException();
    }
    return response;
  }
}
