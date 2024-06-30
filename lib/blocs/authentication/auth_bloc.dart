import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/repositories/authentication/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitialState()) {
    on<AppLoadedEvent>((event, emit) async {
      emit(AuthLoadingState());
      final userInfo = await authRepository.getUser();
      debugPrint("[AuthBloc] AppLoadedEvent userInfo: $userInfo");
      if (userInfo != null) {
        emit(AuthAuthenticatedState(account: userInfo));
      } else {
        emit(AuthNotAuthenticatedState());
      }
    });

    on<LoggedOutEvent>((event, emit) async {
      try {
        emit(AuthNotAuthenticatedState());
        final response = await authRepository.logout();
        if (response.statusCode == HttpStatus.ok) {
          emit(LogoutSuccessState());
        } else {
          emit(LogoutErrolState(message: jsonDecode(response.body)['message']));
        }
        await authRepository.deleteUser();
        await authRepository.deleteToken();
      } catch (e) {
        debugPrint("[AuthBloc] LoggedOutEvent Error: $e");
      }
    });
  }
}
