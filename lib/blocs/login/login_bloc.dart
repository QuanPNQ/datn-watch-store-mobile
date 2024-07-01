import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/login/login_event.dart';
import 'package:flutter_mob/blocs/login/login_state.dart';
import 'package:flutter_mob/models/account/account.dart';
import 'package:flutter_mob/repositories/authentication/auth_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginInitialState()) {
    on<LoginAuthEvent>((event, emit) async {
      emit(LoginLoadingState());
      try {
        var response = await authRepository.login(
            userName: event.userName, password: event.password);
        final body = jsonDecode(response.body);
        if (response.statusCode == HttpStatus.ok) {
          final data = body['data'];
          final information = data['information'];
          Account account = Account.fromJson(information);
          await authRepository.saveToken(data['token']['access']);
          await authRepository.saveUser(account);
          emit(LoginSuccessState());
        } else {
          emit(LoginErrorState(message: body['message']));
        }
      } catch (err) {
        debugPrint("[LoginBloc] LoginAuthEvent error => ${err.toString()}");
        emit(LoginErrorState(message: err.toString()));
      }
    });
  }
}
