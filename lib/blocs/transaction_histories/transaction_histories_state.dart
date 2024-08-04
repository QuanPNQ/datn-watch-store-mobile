import 'package:equatable/equatable.dart';
import 'package:flutter_mob/models/transaction/transaction.dart';

abstract class TransactionHistoriesState extends Equatable {
  const TransactionHistoriesState();

  @override
  List<Object> get props => [];
}

class TransactionHistoriesInitialState extends TransactionHistoriesState {}

class TransactionHistoriesLoadingState extends TransactionHistoriesState {}

class GetListTransactionHistoriesSuccessState
    extends TransactionHistoriesState {
  final List<Transaction> listTransactionHistories;

  const GetListTransactionHistoriesSuccessState(
      {required this.listTransactionHistories});
}

class TransactionHistoriesErrorState extends TransactionHistoriesState {
  final String message;

  const TransactionHistoriesErrorState({required this.message});
}
