import 'package:flutter_mob/service/transaction_histories_service.dart';

class TransactionHistoriesRepository {
  Future<dynamic> getListTransactionHistories() async {
    return await TransactionHistoriesService().getListTransactionHistories();
  }
}
