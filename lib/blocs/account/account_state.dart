import 'package:equatable/equatable.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountInitialState extends AccountState {}

class AccountLoadingState extends AccountState {}

class UpdateProfileSuccessState extends AccountState {}

class ChangePasswordSuccessState extends AccountState {}

class UpdateProfileErrorState extends AccountState {
  final String message;

  const UpdateProfileErrorState({required this.message});
}

class ChangePasswordErrorState extends AccountState {
  final String message;

  const ChangePasswordErrorState({required this.message});
}
