import 'package:equatable/equatable.dart';

abstract class SearchHistoriesEvent extends Equatable {
  const SearchHistoriesEvent();

  @override
  List<Object> get props => [];
}

class GetListSearchHistoriesEvent extends SearchHistoriesEvent {}
