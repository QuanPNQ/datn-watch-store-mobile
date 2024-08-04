import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mob/exception/unauthorized_exception.dart';
import 'package:flutter_mob/service/base_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_mob/configs/constants.dart';

class ProductService extends BaseService {
  Future<dynamic> getListProduct(
      {int? page = 1,
      int? limit = 5,
      TopProductType? type,
      String? brandId,
      String? textSearch}) async {
    String uri = "${Constants.baseUrl}product?page=$page&limit=$limit";
    if (type != null) {
      uri = uri + "&type=${type.name}";
    }
    if (brandId != null) {
      uri = uri + "&brandId=$brandId";
    }
    if (textSearch != null) {
      uri = uri + "&textSearch=$textSearch";
    }
    debugPrint("[ProductService] getListProduct uri: $uri");

    final response =
        await http.get(Uri.parse(uri), headers: await requestTokenHeader());

    debugPrint("[ProductService] getListProduct res  ${response.body}");
    if (response.statusCode == HttpStatus.unauthorized) {
      throw UnauthorizedException();
    }
    return response;
  }

  Future<dynamic> getDetailProduct(String watchId) async {
    String uri = "${Constants.baseUrl}product/$watchId";
    debugPrint("[ProductService] getDetailProduct uri: $uri");

    final response =
        await http.get(Uri.parse(uri), headers: await requestTokenHeader());

    debugPrint("[ProductService] getDetailProduct response: ${response.body}");
    if (response.statusCode == HttpStatus.unauthorized) {
      throw UnauthorizedException();
    }
    return response;
  }

  Future<dynamic> updateProductToCart(
      {required String watchId,
      required int quantity,
      required UpdateCartTypeEnum type}) async {
    String uri = "${Constants.baseUrl}product/$watchId/add-to-cart";
    var body = {"quantity": quantity, "type": type.name};

    debugPrint("[ProductService] updateProductToCart uri: $uri");
    debugPrint("[ProductService] updateProductToCart body: $body");

    final response = await http.post(Uri.parse(uri),
        headers: await requestTokenHeader(), body: jsonEncode(body));

    debugPrint(
        "[ProductService] updateProductToCart response: ${response.body}");
    if (response.statusCode == HttpStatus.unauthorized) {
      throw UnauthorizedException();
    }
    return response;
  }

  Future<dynamic> evaluateProduct(
      {required String productId,
      required String orderId,
      required String comment,
      required double rate}) async {
    String uri = "${Constants.baseUrl}product/$productId/evaluate";
    var body = {"orderId": orderId, "comment": comment, "rate": rate};

    debugPrint("[ProductService] evaluateProduct uri: $uri");
    debugPrint("[ProductService] evaluateProduct body: $body");

    final response = await http.post(Uri.parse(uri),
        headers: await requestTokenHeader(), body: jsonEncode(body));

    debugPrint("[ProductService] evaluateProduct response: ${response.body}");
    if (response.statusCode == HttpStatus.unauthorized) {
      throw UnauthorizedException();
    }
    return response;
  }
}
