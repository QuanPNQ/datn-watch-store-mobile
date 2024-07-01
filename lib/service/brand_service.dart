import 'package:flutter/cupertino.dart';
import 'package:flutter_mob/service/base_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_mob/configs/constants.dart';

class BrandService extends BaseService {
  Future<dynamic> getListBrand({int? page = 1, int? limit = 5}) async {
    String uri = "${Constants.baseUrl}brand?page=$page&limit=$limit";
    debugPrint("[BrandService] getListBrand uri: $uri");

    final response =
        await http.get(Uri.parse(uri), headers: await requestTokenHeader());

    debugPrint("[BrandService] getListBrand response: ${response.body}");
    return response;
  }
}
