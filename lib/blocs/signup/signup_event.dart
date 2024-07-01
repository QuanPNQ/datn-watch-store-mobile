import 'package:equatable/equatable.dart';
import 'package:flutter_mob/models/account/account.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class RegisterEvent extends SignupEvent {
  final Account account;

  const RegisterEvent({required this.account});
}
