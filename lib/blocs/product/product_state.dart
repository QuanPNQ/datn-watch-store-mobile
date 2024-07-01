import 'package:equatable/equatable.dart';
import 'package:flutter_mob/configs/constants.dart';
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
