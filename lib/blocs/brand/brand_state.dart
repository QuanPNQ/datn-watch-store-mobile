import 'package:equatable/equatable.dart';
import 'package:flutter_mob/models/brand/brand.dart';

abstract class BrandState extends Equatable {
  const BrandState();

  @override
  List<Object> get props => [];
}

class BrandInitialState extends BrandState {}

class BrandLoadingState extends BrandState {
  final bool isViewAll;

  const BrandLoadingState({required this.isViewAll});
}

class GetBrandSuccessState extends BrandState {
  final bool isViewAll;
  final List<Brand> listBrand;

  const GetBrandSuccessState(
      {required this.isViewAll, required this.listBrand});
}

class BrandErrorState extends BrandState {
  final bool isViewAll;
  final String message;

  const BrandErrorState({required this.isViewAll, required this.message});
}
