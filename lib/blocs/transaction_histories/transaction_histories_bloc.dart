import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/transaction_histories/transaction_histories_event.dart';
import 'package:flutter_mob/blocs/transaction_histories/transaction_histories_state.dart';
import 'package:flutter_mob/models/transaction/transaction.dart';
import 'package:flutter_mob/repositories/transaction_histories/transaction_histories_repository.dart';

class TransactionHistoriesBloc
    extends Bloc<TransactionHistoriesEvent, TransactionHistoriesState> {
  final TransactionHistoriesRepository transactionHistoriesRepository;

  TransactionHistoriesBloc({required this.transactionHistoriesRepository})
      : super(TransactionHistoriesInitialState()) {
    on<GetListTransactionHistoriesEvent>((event, emit) async {
      try {
        emit(TransactionHistoriesLoadingState());
        var response =
            await transactionHistoriesRepository.getListTransactionHistories();
        final body = jsonDecode(response.body);
        if (response.statusCode == HttpStatus.created) {
          List<Transaction> listTransactionHistories = List.from(body['data']
                  ['transactionHistories']
              .map((e) => Transaction.fromJson(e)));
          emit(GetListTransactionHistoriesSuccessState(
              listTransactionHistories: listTransactionHistories));
        } else {
          emit(TransactionHistoriesErrorState(message: body['message']));
        }
      } catch (err) {
        debugPrint(
            "[TransactionHistoriesBloc] GetListTransactionHistoriesEvent error => ${err.toString()}");
        emit(TransactionHistoriesErrorState(message: err.toString()));
      }
    });
  }
}
