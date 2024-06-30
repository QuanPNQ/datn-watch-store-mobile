import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppLoadedEvent extends AuthEvent {}

class LoggedOutEvent extends AuthEvent {
  final bool isUnauthorized;

  const LoggedOutEvent({this.isUnauthorized = false});
}
