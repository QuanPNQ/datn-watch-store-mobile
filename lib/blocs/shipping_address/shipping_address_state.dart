import 'package:equatable/equatable.dart';
import 'package:flutter_mob/models/models.dart';

abstract class ShippingAddressState extends Equatable {
  const ShippingAddressState();

  @override
  List<Object> get props => [];
}

class ShippingAddressInitialState extends ShippingAddressState {}

class ShippingAddressLoadingState extends ShippingAddressState {}

class GetListAddressSuccessState extends ShippingAddressState {
  final List<ShippingAddress> listAddress;
  final int indexPage;

  const GetListAddressSuccessState(
      {required this.listAddress, required this.indexPage});
}

class GetListAddressErrorState extends ShippingAddressState {
  final String message;
  final int indexPage;

  const GetListAddressErrorState(
      {required this.message, required this.indexPage});
}

class SetDefaultAddressSuccessState extends ShippingAddressState {
  final ShippingAddress shippingAddress;
  final bool isPop;

  const SetDefaultAddressSuccessState(
      {required this.shippingAddress, required this.isPop});
}

class SetDefaultAddressErrorState extends ShippingAddressState {
  final String message;

  const SetDefaultAddressErrorState({required this.message});
}

class DeleteAddressSuccessState extends ShippingAddressState {}

class DeleteAddressErrorState extends ShippingAddressState {
  final String message;

  const DeleteAddressErrorState({required this.message});
}

class AddNewAddressSuccessState extends ShippingAddressState {}

class AddNewAddressErrorState extends ShippingAddressState {
  final String message;

  const AddNewAddressErrorState({required this.message});
}

class UpdateAddressSuccessState extends ShippingAddressState {}

class UpdateAddressErrorState extends ShippingAddressState {
  final String message;

  const UpdateAddressErrorState({required this.message});
}
