import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/service/product_service.dart';

class ProductRepository {
  Future<dynamic> getListProduct(
      {int? page, int? limit, TopProductType? type, String? brandId}) async {
    return await ProductService()
        .getListProduct(page: page, limit: limit, type: type, brandId: brandId);
  }
}
