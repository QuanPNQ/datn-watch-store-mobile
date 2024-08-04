import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/notify/notify_event.dart';
import 'package:flutter_mob/blocs/notify/notify_state.dart';
import 'package:flutter_mob/repositories/notify/notify_repository.dart';
import 'package:flutter_mob/models/notify/notification.dart' as model;

class NotifyBloc extends Bloc<NotifyEvent, NotifyState> {
  final NotifyRepository notifyRepository;

  NotifyBloc({required this.notifyRepository}) : super(NotifyInitialState()) {
    on<GetListNotifyEvent>((event, emit) async {
      try {
        emit(NotifyLoadingState());
        var response = await notifyRepository.getListNotify();
        final body = jsonDecode(response.body);
        if (response.statusCode == HttpStatus.created) {
          List<model.Notification> listNotify = List.from(body['data']
                  ['notifies']
              .map((e) => model.Notification.fromJson(e)));
          emit(GetListNotifySuccessState(listNotify: listNotify));
        } else {
          emit(NotifyErrorState(message: body['message']));
        }
      } catch (err) {
        debugPrint(
            "[NotifyBloc] GetListNotifyEvent error => ${err.toString()}");
        emit(NotifyErrorState(message: err.toString()));
      }
    });

    on<ReadNotifyEvent>((event, emit) async {
      try {
        emit(NotifyLoadingState());
        var response = await notifyRepository.readNotify(event.notifyId);
        final body = jsonDecode(response.body);
        if (response.statusCode == HttpStatus.created) {
          emit(ReadNotifySuccessState(
              quantityNotifyUnread: body['data']['quantityNotifyUnread']));
        } else {
          emit(ReadNotifyErrorState(message: body['message']));
        }
      } catch (err) {
        debugPrint("[NotifyBloc] ReadNotifyEvent error => ${err.toString()}");
        emit(ReadNotifyErrorState(message: err.toString()));
      }
    });
  }
}
