import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/search_histories/search_histories_event.dart';
import 'package:flutter_mob/blocs/search_histories/search_histories_state.dart';
import 'package:flutter_mob/repositories/search_histories/search_histories_repository.dart';
import 'package:flutter_mob/storage/sharedpreferences/shared_preferences_manager.dart';

class SearchHistoriesBloc
    extends Bloc<SearchHistoriesEvent, SearchHistoriesState> {
  final SearchHistoriesRepository searchHistoriesRepository;

  SearchHistoriesBloc({required this.searchHistoriesRepository})
      : super(SearchHistoriesInitialState()) {
    on<GetListSearchHistoriesEvent>((event, emit) async {
      try {
        emit(SearchHistoriesLoadingState());
        var response = await searchHistoriesRepository.getListSearchHistories();
        final body = jsonDecode(response.body);
        if (response.statusCode == HttpStatus.created) {
          List<String> listSearchHistories =
              List.from(body['data']['searchHistories'].map((e) => e["textSearch"]));
          SharedPrefManager? sharedPrefManager =
              await SharedPrefManager.getInstance();
          await sharedPrefManager!.putStringList(
              SharedPrefManager.searchHistoriesKey, listSearchHistories);
          emit(GetListSearchHistoriesSuccessState(
              listSearchHistories: listSearchHistories));
        } else {
          emit(SearchHistoriesErrorState(message: body['message']));
        }
      } catch (err) {
        debugPrint(
            "[SearchHistoriesBloc] GetListSearchHistoriesEvent error => ${err.toString()}");
        emit(SearchHistoriesErrorState(message: err.toString()));
      }
    });
  }
}
