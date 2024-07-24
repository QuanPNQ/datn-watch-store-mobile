import 'package:equatable/equatable.dart';
import 'package:flutter_mob/models/models.dart';

abstract class ShippingAddressEvent extends Equatable {
  const ShippingAddressEvent();

  @override
  List<Object> get props => [];
}

class GetListAddressEvent extends ShippingAddressEvent {
  final int indexPage;

  const GetListAddressEvent({required this.indexPage});
}

class AddNewAddressEvent extends ShippingAddressEvent {
  final String? title;
  final String receiver;
  final String address;
  final String phoneNumber;

  const AddNewAddressEvent(
      {this.title,
      required this.receiver,
      required this.address,
      required this.phoneNumber});
}

class SetDefaultAddressEvent extends ShippingAddressEvent {
  final ShippingAddress shippingAddress;
  final bool isPop;

  const SetDefaultAddressEvent(
      {required this.shippingAddress, required this.isPop});
}

class DeleteAddressEvent extends ShippingAddressEvent {
  final String shippingAddressId;

  const DeleteAddressEvent({required this.shippingAddressId});
}

class UpdateAddressEvent extends ShippingAddressEvent {
  final String shippingAddressId;
  final String? title;
  final String? receiver;
  final String? address;
  final String? phoneNumber;

  const UpdateAddressEvent(
      {required this.shippingAddressId,
      this.title,
      this.receiver,
      this.address,
      this.phoneNumber});
}
