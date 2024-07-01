import 'dart:convert';
import 'package:flutter_mob/models/account/account.dart';
import 'package:flutter_mob/service/auth_service.dart';
import 'package:flutter_mob/storage/sharedpreferences/shared_preferences_manager.dart';

class AuthRepository {
  Future<dynamic> login(
      {required String userName, required String password}) async {
    return await AuthService().login(userName: userName, password: password);
  }

  Future<dynamic> signup({required Account account}) async {
    return await AuthService().signup(account: account);
  }

  Future<dynamic> logout() async {
    return await AuthService().logout();
  }

  Future<void> saveToken(String? token) async {
    SharedPrefManager? sharedPrefManager =
        await SharedPrefManager.getInstance();
    await sharedPrefManager!
        .putString(SharedPrefManager.tokenKey, "Bearer ${token!}");
  }

  static Future<String?> getToken() async {
    SharedPrefManager? sharedPrefManager =
        await SharedPrefManager.getInstance();
    return sharedPrefManager!.getString(SharedPrefManager.tokenKey);
  }

  Future<void> deleteToken() async {
    SharedPrefManager? sharedPrefManager =
        await SharedPrefManager.getInstance();
    await sharedPrefManager!.clearKey(SharedPrefManager.tokenKey);
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

  Future<void> saveUser(Account? userInfo) async {
    SharedPrefManager? sharedPrefManager =
        await SharedPrefManager.getInstance();

    await sharedPrefManager!
        .putString(SharedPrefManager.userInfoKey, jsonEncode(userInfo));
  }

  Future<Account?> getUser() async {
    Account? staffUser;
    SharedPrefManager? sharedPrefManager =
        await SharedPrefManager.getInstance();

    final userJson =
        sharedPrefManager!.getString(SharedPrefManager.userInfoKey);

    if (userJson != null) {
      staffUser = Account.fromJson(jsonDecode(userJson));
    }

    return staffUser;
  }

  Future<void> deleteUser() async {
    SharedPrefManager? sharedPrefManager =
        await SharedPrefManager.getInstance();
    await sharedPrefManager!.clearKey(SharedPrefManager.userInfoKey);
  }
}
