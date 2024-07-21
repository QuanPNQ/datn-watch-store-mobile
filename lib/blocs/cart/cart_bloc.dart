import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/cart/cart_event.dart';
import 'package:flutter_mob/blocs/cart/cart_state.dart';
import 'package:flutter_mob/models/cart/cart_item.dart';
import 'package:flutter_mob/repositories/cart/cart_repository.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  CartBloc({required this.cartRepository}) : super(CartInitialState()) {
    on<GetListCartEvent>((event, emit) async {
      try {
        emit(GetListCartLoadingState());
        var response = await cartRepository.getListCart();
        debugPrint(
            "[CartBloc] GetListCartEvent response => ${response.statusCode}");
        emit(CartInitialState());
        final body = jsonDecode(response.body);
        if (response.statusCode == HttpStatus.created) {
          List<CartItem> listCart =
              List.from(body['data']['carts'].map((e) => CartItem.fromJson(e)));
          emit(GetListCartSuccessState(listCart: listCart));
        } else {
          emit(GetListCartErrorState(message: body['message']));
        }
      } catch (err) {
        debugPrint("[CartBloc] GetListCartEvent error => ${err.toString()}");
        emit(GetListCartErrorState(message: err.toString()));
      }
    });
  }
}
