import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/discount/discount_event.dart';
import 'package:flutter_mob/blocs/discount/discount_state.dart';
import 'package:flutter_mob/models/models.dart';
import 'package:flutter_mob/repositories/discount/discount_repository.dart';

class DiscountBloc extends Bloc<DiscountEvent, DiscountState> {
  final DiscountRepository discountRepository;

  DiscountBloc({required this.discountRepository})
      : super(DiscountInitialState()) {
    on<GetListDiscountEvent>((event, emit) async {
      try {
        emit(DiscountLoadingState());
        var response = await discountRepository.getListDiscount();
        final body = jsonDecode(response.body);
        if (response.statusCode == HttpStatus.created) {
          List<Discount> listDiscount = List.from(
              body['data']['discounts'].map((e) => Discount.fromJson(e)));
          emit(GetListDiscountSuccessState(listDiscount: listDiscount));
        } else {
          emit(DiscountErrorState(message: body['message']));
        }
      } catch (err) {
        debugPrint(
            "[DiscountBloc] GetListDiscountEvent error => ${err.toString()}");
        emit(DiscountErrorState(message: err.toString()));
      }
    });
  }
}
