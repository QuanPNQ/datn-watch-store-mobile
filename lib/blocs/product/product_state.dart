import 'package:equatable/equatable.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/models/cart/cart_item.dart';
import 'package:flutter_mob/models/watch/watch.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitialState extends ProductState {}

/// Get Classic Product
class GetClassicProductLoadingState extends ProductState {}

class GetClassicProductSuccessState extends ProductState {
  final TopProductType? type;
  final List<Watch> listWatch;

  const GetClassicProductSuccessState(
      {required this.type, required this.listWatch});
}

class GetClassicProductErrorState extends ProductState {
  final String message;

  const GetClassicProductErrorState({required this.message});
}

/// Get Top Deel Product
class GetTopDeelProductLoadingState extends ProductState {
  final bool isViewAll;

  const GetTopDeelProductLoadingState({required this.isViewAll});
}

class GetTopDeelProductSuccessState extends ProductState {
  final bool isViewAll;
  final List<Watch> listWatch;

  const GetTopDeelProductSuccessState(
      {required this.isViewAll, required this.listWatch});
}

class GetTopDeelProductErrorState extends ProductState {
  final bool isViewAll;
  final String message;

  const GetTopDeelProductErrorState(
      {required this.isViewAll, required this.message});
}

/// Get Outstanding Product
class GetOutstandingProductLoadingState extends ProductState {
  final bool isViewAll;

  const GetOutstandingProductLoadingState({required this.isViewAll});
}

class GetOutstandingProductSuccessState extends ProductState {
  final bool isViewAll;
  final List<Watch> listWatch;

  const GetOutstandingProductSuccessState(
      {required this.isViewAll, required this.listWatch});
}

class GetOutstandingProductErrorState extends ProductState {
  final bool isViewAll;
  final String message;

  const GetOutstandingProductErrorState(
      {required this.isViewAll, required this.message});
}

/// Get Product By Brand
class GetProductByBrandLoadingState extends ProductState {}

class GetProductByBrandSuccessState extends ProductState {
  final List<Watch> listWatch;

  const GetProductByBrandSuccessState({required this.listWatch});
}

class GetProductByBrandErrorState extends ProductState {
  final String message;

  const GetProductByBrandErrorState({required this.message});
}

/// Get Detail Product
class GetDetailProductLoadingState extends ProductState {}

class GetDetailProductSuccessState extends ProductState {
  final Watch watch;

  const GetDetailProductSuccessState({required this.watch});
}

class GetDetailProductErrorState extends ProductState {
  final String message;

  const GetDetailProductErrorState({required this.message});
}

/// Update Product To Cart
class UpdateProductToCartLoadingState extends ProductState {
  final bool isShowToast;

  const UpdateProductToCartLoadingState({required this.isShowToast});
}

class UpdateProductToCartSuccessState extends ProductState {
  final int quantity;
  final UpdateCartTypeEnum type;
  final List<CartItem> listCart;
  final bool isShowToast;

  const UpdateProductToCartSuccessState(
      {required this.quantity,
      required this.type,
      required this.listCart,
      required this.isShowToast});
}

class UpdateProductToCartErrorState extends ProductState {
  final String message;

  const UpdateProductToCartErrorState({required this.message});
}

/// Get List Product
class GetListProductLoadingState extends ProductState {}

class GetListProductSuccessState extends ProductState {
  final List<Watch> listWatch;

  const GetListProductSuccessState({required this.listWatch});
}

class GetListProductErrorState extends ProductState {
  final String message;

  const GetListProductErrorState({required this.message});
}

/// Evaluate Product
class EvaluateProductLoadingState extends ProductState {}

class EvaluateProductSuccessState extends ProductState {}

class EvaluateProductErrorState extends ProductState {
  final String message;

  const EvaluateProductErrorState({required this.message});
}
