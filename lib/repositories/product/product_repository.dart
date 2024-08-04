import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/service/product_service.dart';

class ProductRepository {
  Future<dynamic> getListProduct(
      {int? page,
      int? limit,
      TopProductType? type,
      String? brandId,
      String? textSearch}) async {
    return await ProductService().getListProduct(
        page: page,
        limit: limit,
        type: type,
        brandId: brandId,
        textSearch: textSearch);
  }

  Future<dynamic> getDetailProduct(String watchId) async {
    return await ProductService().getDetailProduct(watchId);
  }

  Future<dynamic> updateProductToCart(
      {required String watchId,
      required int quantity,
      required UpdateCartTypeEnum type}) async {
    return await ProductService()
        .updateProductToCart(watchId: watchId, quantity: quantity, type: type);
  }

  Future<dynamic> evaluateProduct(
      {required String productId,
      required String orderId,
      required String comment,
      required double rate}) async {
    return await ProductService().evaluateProduct(
        productId: productId, orderId: orderId, comment: comment, rate: rate);
  }
}
