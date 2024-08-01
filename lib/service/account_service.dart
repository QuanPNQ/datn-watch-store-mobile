import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mob/exception/unauthorized_exception.dart';
import 'package:flutter_mob/service/base_service.dart';
import 'package:flutter_mob/utils/pick_image_helper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_mob/configs/constants.dart';

class AccountService extends BaseService {
  Future<dynamic> updateProfile(
      {String? userName, String? email, String? filePath}) async {
    String uri = "${Constants.baseUrl}account";
    debugPrint("[AccountService] updateProfile uri: $uri");

    Map<String, String> headers = await requestTokenHeader();
    final request = await http.MultipartRequest('PUT', Uri.parse(uri));
    request.headers.addAll(headers);
    Map<String, String> body = {};
    if (userName != null) {
      body["userName"] = userName;
    }
    if (email != null) {
      body["email"] = email;
    }
    request.fields.addAll(body);
    if (filePath != null) {
      request.files.add(await http.MultipartFile.fromBytes(
          'avatar', await PickImageHelper.fileToBytes(filePath)));
    }

    var response = await http.Response.fromStream(await request.send());

    debugPrint("[AccountService] updateProfile res  ${response.body}");
    if (response.statusCode == HttpStatus.unauthorized) {
      throw UnauthorizedException();
    }
    return response;
  }

  Future<dynamic> changePassword(
      {required String oldPassword, required String newPassword}) async {
    String uri = "${Constants.baseUrl}account/change-password";
    var body = {"oldPassword": oldPassword, "newPassword": newPassword};
    debugPrint("[AccountService] changePassword uri: $uri");
    debugPrint("[AccountService] changePassword body: $body");

    final response = await http.put(Uri.parse(uri),
        headers: await requestTokenHeader(), body: jsonEncode(body));

    debugPrint("[AccountService] changePassword res  ${response.body}");
    if (response.statusCode == HttpStatus.unauthorized) {
      throw UnauthorizedException();
    }
    return response;
  }
}
