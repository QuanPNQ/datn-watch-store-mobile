import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mob/exception/unauthorized_exception.dart';
import 'package:flutter_mob/service/base_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_mob/configs/constants.dart';

class ShippingAddressService extends BaseService {
  Future<dynamic> getListAddress() async {
    String uri = "${Constants.baseUrl}shipping-address";
    debugPrint("[ShippingAddressService] getListAddress uri: $uri");

    final response =
        await http.get(Uri.parse(uri), headers: await requestTokenHeader());

    debugPrint("[ShippingAddressService] getListCart res  ${response.body}");
    if (response.statusCode == HttpStatus.unauthorized) {
      throw UnauthorizedException();
    }
    return response;
  }

  Future<dynamic> addNewAddress(
      {String? title,
      required String receiver,
      required String address,
      required String phoneNumber}) async {
    String uri = "${Constants.baseUrl}shipping-address/new";
    var body = {
      "receiver": receiver,
      "address": address,
      "phoneNumber": phoneNumber,
    };
    if (title != null) {
      body["title"] = title;
    }
    debugPrint("[ShippingAddressService] addNewAddress uri: $uri");
    debugPrint("[ShippingAddressService] addNewAddress body: $body");

    final response = await http.post(Uri.parse(uri),
        headers: await requestTokenHeader(), body: jsonEncode(body));

    debugPrint("[ShippingAddressService] addNewAddress res  ${response.body}");
    if (response.statusCode == HttpStatus.unauthorized) {
      throw UnauthorizedException();
    }
    return response;
  }

  Future<dynamic> setDefaultAddress({required String shippingAddressId}) async {
    String uri =
        "${Constants.baseUrl}shipping-address/$shippingAddressId/set-default";
    debugPrint("[ShippingAddressService] setDefaultAddress uri: $uri");

    final response =
        await http.put(Uri.parse(uri), headers: await requestTokenHeader());

    debugPrint(
        "[ShippingAddressService] setDefaultAddress res  ${response.body}");
    if (response.statusCode == HttpStatus.unauthorized) {
      throw UnauthorizedException();
    }
    return response;
  }

  Future<dynamic> updateAddress(
      {required String shippingAddressId,
      String? title,
      String? receiver,
      String? address,
      String? phoneNumber}) async {
    String uri = "${Constants.baseUrl}shipping-address/$shippingAddressId";
    var body = {};
    if (title != null) {
      body["title"] = title;
    }
    if (receiver != null) {
      body["receiver"] = receiver;
    }
    if (address != null) {
      body["address"] = address;
    }
    if (phoneNumber != null) {
      body["phoneNumber"] = phoneNumber;
    }
    debugPrint("[ShippingAddressService] updateAddress uri: $uri");
    debugPrint("[ShippingAddressService] updateAddress body: $body");

    final response = await http.put(Uri.parse(uri),
        headers: await requestTokenHeader(), body: jsonEncode(body));

    debugPrint("[ShippingAddressService] updateAddress res  ${response.body}");
    if (response.statusCode == HttpStatus.unauthorized) {
      throw UnauthorizedException();
    }
    return response;
  }

  Future<dynamic> deleteAddress({required String shippingAddressId}) async {
    String uri = "${Constants.baseUrl}shipping-address/$shippingAddressId";
    debugPrint("[ShippingAddressService] deleteAddress uri: $uri");

    final response =
        await http.delete(Uri.parse(uri), headers: await requestTokenHeader());

    debugPrint("[ShippingAddressService] deleteAddress res  ${response.body}");
    if (response.statusCode == HttpStatus.unauthorized) {
      throw UnauthorizedException();
    }
    return response;
  }
}
