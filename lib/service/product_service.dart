import 'package:flutter/cupertino.dart';
import 'package:flutter_mob/service/base_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_mob/configs/constants.dart';

class ProductService extends BaseService {
  Future<dynamic> getListProduct(
      {int? page = 1, int? limit = 5, TopProductType? type}) async {
    String uri = "${Constants.baseUrl}product?page=$page&limit=$limit";
    if (type != null) {
      uri = uri + "&type=${type.name}";
    }
    debugPrint("[ProductService] getListProduct uri: $uri");

    final response =
        await http.get(Uri.parse(uri), headers: await requestTokenHeader());

    debugPrint("[ProductService] getListProduct response: ${response.body}");
    return response;
  }
}
