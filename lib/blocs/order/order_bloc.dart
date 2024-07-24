import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/order/order_event.dart';
import 'package:flutter_mob/blocs/order/order_state.dart';
import 'package:flutter_mob/models/models.dart';
import 'package:flutter_mob/repositories/order/order_repository.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;

  OrderBloc({required this.orderRepository}) : super(OrderInitialState()) {
    on<ProcessOrderEvent>((event, emit) async {
      try {
        emit(OrderLoadingState());
        var response = await orderRepository.processOrder();
        final body = jsonDecode(response.body);
        if (response.statusCode == HttpStatus.created) {
          Order order = Order.fromJson(body['data']['order']);
          emit(ProcessOrderSuccessState(order: order));
        } else {
          emit(ProcessOrderErrorState(message: body['message']));
        }
      } catch (err) {
        debugPrint("[OrderBloc] ProcessOrderEvent error => ${err.toString()}");
        emit(ProcessOrderErrorState(
          message: err.toString(),
        ));
      }
    });

    on<ConfirmOrderEvent>((event, emit) async {
      try {
        emit(OrderLoadingState());
        var response = await orderRepository.confirmOrder(
            orderId: event.orderId,
            shippingAddressId: event.shippingAddressId,
            discountId: event.discountId,
            paymentMethod: event.paymentMethod);
        final body = jsonDecode(response.body);
        if (response.statusCode == HttpStatus.created) {
          emit(ConfirmOrderSuccessState());
        } else {
          emit(ConfirmOrderErrorState(message: body['message']));
        }
      } catch (err) {
        debugPrint("[OrderBloc] ConfirmOrderEvent error => ${err.toString()}");
        emit(ConfirmOrderErrorState(
          message: err.toString(),
        ));
      }
    });

    on<CreatePaymentOrderEvent>((event, emit) async {
      try {
        emit(OrderLoadingState());
        var response = await orderRepository.createPaymentOrder(
            orderId: event.orderId,
            shippingAddressId: event.shippingAddressId,
            discountId: event.discountId);
        final body = jsonDecode(response.body);
        if (response.statusCode == HttpStatus.ok) {
          emit(CreatePaymentOrderSuccessState(
              paymentUrl: body['data']['vnpUrl']));
        } else {
          emit(CreatePaymentOrderErrorState(message: body['message']));
        }
      } catch (err) {
        debugPrint(
            "[OrderBloc] CreatePaymentOrderEvent error => ${err.toString()}");
        emit(CreatePaymentOrderErrorState(
          message: err.toString(),
        ));
      }
    });

    on<CheckOrderEvent>((event, emit) async {
      try {
        emit(OrderLoadingState());
        var response = await orderRepository.checkOrder(orderId: event.orderId);
        final body = jsonDecode(response.body);
        if (response.statusCode == HttpStatus.created) {
          emit(CheckOrderSuccessState(body["data"]["isOrder"]));
        } else {
          emit(CheckOrderErrorState(message: body['message']));
        }
      } catch (err) {
        debugPrint("[OrderBloc] CheckOrderEvent error => ${err.toString()}");
        emit(CheckOrderErrorState(
          message: err.toString(),
        ));
      }
    });
  }
}
