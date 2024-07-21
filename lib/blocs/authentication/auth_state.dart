import 'package:equatable/equatable.dart';
import 'package:flutter_mob/models/account/account.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthNotAuthenticatedState extends AuthState {}

class AuthUnauthorizedState extends AuthState {}

class AuthAuthenticatedState extends AuthState {
  final Account account;

  const AuthAuthenticatedState({required this.account});
}

class LogoutSuccessState extends AuthState {}

class LogoutErrolState extends AuthState {
  final String message;

  const LogoutErrolState({required this.message});
}
