import 'package:flutter_mob/service/account_service.dart';

class AccountRepository {
  Future<dynamic> updateProfile(
      {String? userName, String? email, String? filePath}) async {
    return await AccountService()
        .updateProfile(userName: userName, email: email, filePath: filePath);
  }

  Future<dynamic> changePassword(
      {required String oldPassword, required String newPassword}) async {
    return await AccountService()
        .changePassword(oldPassword: oldPassword, newPassword: newPassword);
  }
}
