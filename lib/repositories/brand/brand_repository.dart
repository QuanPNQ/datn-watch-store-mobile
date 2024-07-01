import 'package:flutter_mob/service/brand_service.dart';

class BrandRepository {
  Future<dynamic> getListBrand({int? page, int? limit}) async {
    return await BrandService().getListBrand(page: page, limit: limit);
  }
}
