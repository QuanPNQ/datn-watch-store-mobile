import 'package:flutter_mob/service/auth_service.dart';
import 'package:flutter_mob/storage/sharedpreferences/shared_preferences_manager.dart';

class AuthRepository {
  Future<dynamic> login(
      {required String email, required String password}) async {
    var res = await AuthService().login(email: email, password: password);
    return res;
  }

  Future<bool> hasToken() async {
    SharedPrefManager? sharedPrefManager =
        await SharedPrefManager.getInstance();
    var token = sharedPrefManager!.getString(SharedPrefManager.tokenKey);

    if (token != null) {
      return true;
    }
    return false;
  }
}
