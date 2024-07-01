import 'package:equatable/equatable.dart';
import 'package:flutter_mob/models/brand/brand.dart';

abstract class BrandState extends Equatable {
  const BrandState();

  @override
  List<Object> get props => [];
}

class BrandInitialState extends BrandState {}

class BrandLoadingState extends BrandState {}

class GetBrandSuccessState extends BrandState {
  final List<Brand> listBrand;

  const GetBrandSuccessState({required this.listBrand});
}

class BrandErrorState extends BrandState {
  final String message;

  const BrandErrorState({required this.message});
}
