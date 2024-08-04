import 'package:equatable/equatable.dart';
import 'package:flutter_mob/models/order/order.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitialState extends OrderState {}

class OrderLoadingState extends OrderState {}

class ProcessOrderSuccessState extends OrderState {
  final Order order;

  ProcessOrderSuccessState({required this.order});
}

class ProcessOrderErrorState extends OrderState {
  final String message;

  const ProcessOrderErrorState({required this.message});
}

class ConfirmOrderSuccessState extends OrderState {}

class ConfirmOrderErrorState extends OrderState {
  final String message;

  const ConfirmOrderErrorState({required this.message});
}

class CreatePaymentOrderSuccessState extends OrderState {
  final String paymentUrl;

  const CreatePaymentOrderSuccessState({required this.paymentUrl});
}

class CreatePaymentOrderErrorState extends OrderState {
  final String message;

  const CreatePaymentOrderErrorState({required this.message});
}

class CheckOrderSuccessState extends OrderState {
  final bool isOrder;

  const CheckOrderSuccessState(this.isOrder);
}

class CheckOrderErrorState extends OrderState {
  final String message;

  const CheckOrderErrorState({required this.message});
}

class GetListOrderSuccessState extends OrderState {
  final List<Order> orders;

  const GetListOrderSuccessState(this.orders);
}

class GetListOrderErrorState extends OrderState {
  final String message;

  const GetListOrderErrorState({required this.message});
}

class CancelOrderSuccessState extends OrderState {}

class CancelOrderErrorState extends OrderState {
  final String message;

  const CancelOrderErrorState({required this.message});
}
