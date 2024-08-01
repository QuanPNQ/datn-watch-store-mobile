import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/account/account_event.dart';
import 'package:flutter_mob/blocs/account/account_state.dart';
import 'package:flutter_mob/models/account/account.dart';
import 'package:flutter_mob/repositories/account/account_repository.dart';
import 'package:flutter_mob/repositories/authentication/auth_repository.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository accountRepository;

  AccountBloc({required this.accountRepository})
      : super(AccountInitialState()) {
    on<UpdateProfileEvent>((event, emit) async {
      try {
        emit(AccountLoadingState());
        var response = await accountRepository.updateProfile(
            email: event.email,
            userName: event.userName,
            filePath: event.filePath);
        final body = jsonDecode(response.body);
        if (response.statusCode == HttpStatus.created) {
          Account account = Account.fromJson(body['data']['account']);
          await AuthRepository().saveUser(account);
          emit(UpdateProfileSuccessState());
        } else {
          emit(UpdateProfileErrorState(message: body['message']));
        }
      } catch (err) {
        debugPrint(
            "[AccountBloc] UpdateProfileEvent error => ${err.toString()}");
        emit(UpdateProfileErrorState(message: err.toString()));
      }
    });

    on<ChangePasswordEvent>((event, emit) async {
      try {
        emit(AccountLoadingState());
        var response = await accountRepository.changePassword(
            oldPassword: event.oldPassword, newPassword: event.newPassword);
        final body = jsonDecode(response.body);
        if (response.statusCode == HttpStatus.created) {
          emit(ChangePasswordSuccessState());
        } else {
          emit(ChangePasswordErrorState(message: body['message']));
        }
      } catch (err) {
        debugPrint(
            "[AccountBloc] ChangePasswordEvent error => ${err.toString()}");
        emit(ChangePasswordErrorState(message: err.toString()));
      }
    });
  }
}
