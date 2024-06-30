import 'package:flutter_mob/repositories/authentication/auth_repository.dart';

abstract class BaseService {
  Future<Map<String, String>> requestTokenHeader() async {
    var token = await AuthRepository.getToken();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': token!
    };
    return requestHeaders;
  }
}
