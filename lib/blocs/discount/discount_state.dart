import 'package:equatable/equatable.dart';
import 'package:flutter_mob/models/models.dart';

abstract class DiscountState extends Equatable {
  const DiscountState();

  @override
  List<Object> get props => [];
}

class DiscountInitialState extends DiscountState {}

class DiscountLoadingState extends DiscountState {}

class GetListDiscountSuccessState extends DiscountState {
  final List<Discount> listDiscount;

  const GetListDiscountSuccessState({required this.listDiscount});
}

class DiscountErrorState extends DiscountState {
  final String message;

  const DiscountErrorState({required this.message});
}
