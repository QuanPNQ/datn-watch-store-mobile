import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginAuthEvent extends LoginEvent {
  final String userName;
  final String password;

  const LoginAuthEvent({required this.userName, required this.password});
}
