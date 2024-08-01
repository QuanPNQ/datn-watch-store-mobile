import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfileEvent extends AccountEvent {
  final String? userName;
  final String? email;
  final String? filePath;

  UpdateProfileEvent({this.userName, this.email, this.filePath});
}

class ChangePasswordEvent extends AccountEvent {
  final String oldPassword;
  final String newPassword;

  ChangePasswordEvent({required this.oldPassword, required this.newPassword});
}
