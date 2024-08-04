import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mob/exception/unauthorized_exception.dart';
import 'package:flutter_mob/service/base_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_mob/configs/constants.dart';

class OrderService extends BaseService {
  Future<dynamic> processOrder() async {
    String uri = "${Constants.baseUrl}order/proccess";
    debugPrint("[OrderService] processOrder uri: $uri");

    final response =
        await http.post(Uri.parse(uri), headers: await requestTokenHeader());

    debugPrint("[ProductService] processOrder res  ${response.body}");
    if (response.statusCode == HttpStatus.unauthorized) {
      throw UnauthorizedException();
    }
    return response;
  }

  Future<dynamic> confirmOrder({
    required String orderId,
    required String shippingAddressId,
    required String paymentMethod,
    String? discountId,
  }) async {
    String uri = "${Constants.baseUrl}order/$orderId/confirm";
    var body = {
      "shippingAddressId": shippingAddressId,
      "paymentMethod": paymentMethod
    };
    if (discountId != null) {
      body["discountId"] = discountId;
    }

    debugPrint("[OrderService] confirmOrder uri: $uri");
    debugPrint("[OrderService] confirmOrder body: $body");

    final response = await http.post(Uri.parse(uri),
        headers: await requestTokenHeader(), body: jsonEncode(body));

    debugPrint("[OrderService] confirmOrder res  ${response.body}");
    if (response.statusCode == HttpStatus.unauthorized) {
      throw UnauthorizedException();
    }
    return response;
  }

  Future<dynamic> createPaymentOrder({
    required String orderId,
    required String shippingAddressId,
    String? discountId,
  }) async {
    String uri = "${Constants.baseUrl}order/$orderId/create-payment";
    var body = {"shippingAddressId": shippingAddressId};
    if (discountId != null) {
      body["discountId"] = discountId;
    }

    debugPrint("[OrderService] createPaymentOrder uri: $uri");
    debugPrint("[OrderService] createPaymentOrder body: $body");

    final response = await http.post(Uri.parse(uri),
        headers: await requestTokenHeader(), body: jsonEncode(body));

    debugPrint("[OrderService] createPaymentOrder res  ${response.body}");
    if (response.statusCode == HttpStatus.unauthorized) {
      throw UnauthorizedException();
    }
    return response;
  }

  Future<dynamic> checkOrder({
    required String orderId,
  }) async {
    String uri = "${Constants.baseUrl}order/$orderId/check-payment";
    debugPrint("[OrderService] checkOrder uri: $uri");

    final response = await http.get(
      Uri.parse(uri),
      headers: await requestTokenHeader(),
    );

    debugPrint("[OrderService] checkOrder res  ${response.body}");
    if (response.statusCode == HttpStatus.unauthorized) {
      throw UnauthorizedException();
    }
    return response;
  }

  Future<dynamic> getListOrder({
    String? status,
  }) async {
    String uri = "${Constants.baseUrl}order";
    if (status != null) {
      uri = uri + "?status=${status}";
    }
    debugPrint("[OrderService] getListOrder uri: $uri");

    final response = await http.get(
      Uri.parse(uri),
      headers: await requestTokenHeader(),
    );

    debugPrint("[OrderService] getListOrder res  ${response.body}");
    if (response.statusCode == HttpStatus.unauthorized) {
      throw UnauthorizedException();
    }
    return response;
  }

  Future<dynamic> cancelOrder({
    required String orderId,
    required String reason,
  }) async {
    String uri = "${Constants.baseUrl}order/$orderId/cancel";
    debugPrint("[OrderService] cancelOrder uri: $uri");

    var body = {"reason": reason};

    final response = await http.put(Uri.parse(uri),
        headers: await requestTokenHeader(), body: jsonEncode(body));

    debugPrint("[OrderService] cancelOrder res  ${response.body}");
    if (response.statusCode == HttpStatus.unauthorized) {
      throw UnauthorizedException();
    }
    return response;
  }
}
