import 'package:flutter_mob/service/search_histories_service.dart';

class SearchHistoriesRepository {
  Future<dynamic> getListSearchHistories() async {
    return await SearchHistoriesService().getListSearchHistories();
  }
}
