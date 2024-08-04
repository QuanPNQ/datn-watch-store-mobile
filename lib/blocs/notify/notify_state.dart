import 'package:equatable/equatable.dart';
import 'package:flutter_mob/models/notify/notification.dart';

abstract class NotifyState extends Equatable {
  const NotifyState();

  @override
  List<Object> get props => [];
}

class NotifyInitialState extends NotifyState {}

class NotifyLoadingState extends NotifyState {}

class GetListNotifySuccessState extends NotifyState {
  final List<Notification> listNotify;

  const GetListNotifySuccessState({required this.listNotify});
}

class ReadNotifySuccessState extends NotifyState {
  final int quantityNotifyUnread;

  const ReadNotifySuccessState({required this.quantityNotifyUnread});
}

class NotifyErrorState extends NotifyState {
  final String message;

  const NotifyErrorState({required this.message});
}

class ReadNotifyErrorState extends NotifyState {
  final String message;

  const ReadNotifyErrorState({required this.message});
}
