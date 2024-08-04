import 'package:equatable/equatable.dart';

abstract class NotifyEvent extends Equatable {
  const NotifyEvent();

  @override
  List<Object> get props => [];
}

class GetListNotifyEvent extends NotifyEvent {}

class ReadNotifyEvent extends NotifyEvent {
  final String notifyId;

  ReadNotifyEvent(this.notifyId);
}
