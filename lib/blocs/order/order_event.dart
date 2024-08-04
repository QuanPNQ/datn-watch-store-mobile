import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class ProcessOrderEvent extends OrderEvent {}

class ConfirmOrderEvent extends OrderEvent {
  final String orderId;
  final String shippingAddressId;
  final String? discountId;
  final String paymentMethod;

  ConfirmOrderEvent({
    required this.orderId,
    required this.shippingAddressId,
    required this.paymentMethod,
    this.discountId,
  });
}

class CreatePaymentOrderEvent extends OrderEvent {
  final String orderId;
  final String shippingAddressId;
  final String? discountId;

  CreatePaymentOrderEvent({
    required this.orderId,
    required this.shippingAddressId,
    this.discountId,
  });
}

class CheckOrderEvent extends OrderEvent {
  final String orderId;

  CheckOrderEvent({
    required this.orderId,
  });
}

class GetListOrderEvent extends OrderEvent {
  final String? status;

  GetListOrderEvent({
    this.status,
  });
}

class CancelOrderEvent extends OrderEvent {
  final String orderId;
  final String reason;

  CancelOrderEvent({
    required this.orderId,
    required this.reason,
  });
}
