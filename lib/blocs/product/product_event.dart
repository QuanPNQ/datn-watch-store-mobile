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
