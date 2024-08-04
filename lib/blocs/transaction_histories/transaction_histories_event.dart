import 'package:equatable/equatable.dart';

abstract class TransactionHistoriesEvent extends Equatable {
  const TransactionHistoriesEvent();

  @override
  List<Object> get props => [];
}

class GetListTransactionHistoriesEvent extends TransactionHistoriesEvent {}
