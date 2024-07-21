import 'package:equatable/equatable.dart';
import 'package:flutter_mob/models/cart/cart_item.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitialState extends CartState {}

class GetListCartLoadingState extends CartState {}

class GetListCartSuccessState extends CartState {
  final List<CartItem> listCart;

  const GetListCartSuccessState({required this.listCart});
}

class GetListCartErrorState extends CartState {
  final String message;

  const GetListCartErrorState({required this.message});
}
