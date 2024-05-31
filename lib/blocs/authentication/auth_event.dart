import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoggedOutEvent extends AuthEvent {}

class LoginKamEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginKamEvent({required this.email, required this.password});
}
