import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/authentication/auth_event.dart';
import 'package:flutter_mob/blocs/authentication/auth_state.dart';
import 'package:flutter_mob/repositories/authentication/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitialState()) {
    on<LoginKamEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        var response = await authRepository.login(
            email: event.email, password: event.password);
        if (response.statusCode == HttpStatus.ok) {
          emit(AuthLoginSuccessState());
        } else {
          emit(AuthErrorState(message: response.message));
        }
      } catch (err) {
        debugPrint("[AUTH BLOC] ERROR RES => ${err.toString()}");
        emit(AuthErrorState(message: err.toString()));
      }
    });

    on<LoggedOutEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        emit(AuthLogoutSuccessState());
      } catch (err) {
        debugPrint("[AUTH BLOC] ERROR RES => ${err.toString()}");
        emit(AuthErrorState(message: err.toString()));
      }
    });
  }
}
