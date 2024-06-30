import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/signup/signup_event.dart';
import 'package:flutter_mob/blocs/signup/signup_state.dart';
import 'package:flutter_mob/repositories/authentication/auth_repository.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepository authRepository;

  SignupBloc({required this.authRepository}) : super(SignupInitialState()) {
    on<RegisterEvent>((event, emit) async {
      emit(SignupLoadingState());
      try {
        var response = await authRepository.signup(account: event.account);
        final body = jsonDecode(response.body);
        if (response.statusCode == HttpStatus.ok) {
          emit(SignupSuccessState());
        } else {
          emit(SignupErrorState(message: body['message']));
        }
      } catch (err) {
        debugPrint("[SignupBloc] RegisterEvent error => ${err.toString()}");
        emit(SignupErrorState(message: err.toString()));
      }
    });
  }
}
