import 'package:equatable/equatable.dart';
import 'package:flutter_mob/models/notify/notification.dart';

abstract class SearchHistoriesState extends Equatable {
  const SearchHistoriesState();

  @override
  List<Object> get props => [];
}

class SearchHistoriesInitialState extends SearchHistoriesState {}

class SearchHistoriesLoadingState extends SearchHistoriesState {}

class GetListSearchHistoriesSuccessState extends SearchHistoriesState {
  final List<String> listSearchHistories;

  const GetListSearchHistoriesSuccessState({required this.listSearchHistories});
}

class SearchHistoriesErrorState extends SearchHistoriesState {
  final String message;

  const SearchHistoriesErrorState({required this.message});
}
