import 'package:equatable/equatable.dart';
import 'package:flutter_mob/configs/constants.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetClassicProductEvent extends ProductEvent {
  final TopProductType? type;
  final int? page;
  final int? limit;

  const GetClassicProductEvent({this.type, this.page, this.limit});
}

class GetTopDeelProductEvent extends ProductEvent {
  final bool isViewAll;
  final TopProductType? type;
  final int? page;
  final int? limit;

  const GetTopDeelProductEvent(
      {this.isViewAll = false,
      this.type = TopProductType.PRICE,
      this.page,
      this.limit});
}

class GetOutstandingProductEvent extends ProductEvent {
  final bool isViewAll;
  final int? page;
  final int? limit;

  const GetOutstandingProductEvent(
      {this.isViewAll = false, this.page, this.limit});
}

class GetProductByBrandEvent extends ProductEvent {
  final int? page;
  final int? limit;
  final String brandId;

  const GetProductByBrandEvent({required this.brandId, this.page, this.limit});
}

class GetDetailProductEvent extends ProductEvent {
  final String watchId;

  const GetDetailProductEvent({
    required this.watchId,
  });
}

class UpdateProductToCartEvent extends ProductEvent {
  final String watchId;
  final int quantity;
  final UpdateCartTypeEnum type;
  final bool isShowToast;

  const UpdateProductToCartEvent(
      {required this.watchId,
      required this.quantity,
      required this.type,
      this.isShowToast = true});
}

class GetListProductEvent extends ProductEvent {
  final int? page;
  final int? limit;
  final String? textSearch;

  const GetListProductEvent({this.page, this.limit, this.textSearch});
}

class EvaluateProductEvent extends ProductEvent {
  final String productId;
  final String orderId;
  final String comment;
  final double rate;

  const EvaluateProductEvent(
      {required this.productId,
      required this.orderId,
      required this.comment,
      required this.rate});
}
