import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/shipping_address/shipping_address_event.dart';
import 'package:flutter_mob/blocs/shipping_address/shipping_address_state.dart';
import 'package:flutter_mob/models/models.dart';
import 'package:flutter_mob/repositories/shippingAddress/shipping_address_repository.dart';

class ShippingAddressBloc
    extends Bloc<ShippingAddressEvent, ShippingAddressState> {
  final ShippingAddressRepository shippingAddressRepository;

  ShippingAddressBloc({required this.shippingAddressRepository})
      : super(ShippingAddressInitialState()) {
    on<GetListAddressEvent>((event, emit) async {
      try {
        emit(ShippingAddressLoadingState());
        var response = await shippingAddressRepository.getListAddress();
        final body = jsonDecode(response.body);
        if (response.statusCode == HttpStatus.created) {
          List<ShippingAddress> listAddress = List.from(body['data']
                  ['addresses']
              .map((e) => ShippingAddress.fromJson(e)));
          emit(GetListAddressSuccessState(
              listAddress: listAddress, indexPage: event.indexPage));
        } else {
          emit(GetListAddressErrorState(
              message: body['message'], indexPage: event.indexPage));
        }
      } catch (err) {
        debugPrint(
            "[ShippingAddressBloc] GetListAddressEvent error => ${err.toString()}");
        emit(GetListAddressErrorState(
            message: err.toString(), indexPage: event.indexPage));
      }
    });

    on<SetDefaultAddressEvent>((event, emit) async {
      try {
        emit(ShippingAddressLoadingState());
        var response = await shippingAddressRepository.setDefaultAddress(
            shippingAddressId: event.shippingAddress.id);
        final body = jsonDecode(response.body);
        if (response.statusCode == HttpStatus.created) {
          emit(SetDefaultAddressSuccessState(
              shippingAddress: event.shippingAddress, isPop: event.isPop));
        } else {
          emit(SetDefaultAddressErrorState(message: body['message']));
        }
      } catch (err) {
        debugPrint(
            "[ShippingAddressBloc] SetDefaultAddressEvent error => ${err.toString()}");
        emit(SetDefaultAddressErrorState(
          message: err.toString(),
        ));
      }
    });

    on<DeleteAddressEvent>((event, emit) async {
      try {
        emit(ShippingAddressLoadingState());
        var response = await shippingAddressRepository.deleteAddress(
            shippingAddressId: event.shippingAddressId);
        final body = jsonDecode(response.body);
        if (response.statusCode == HttpStatus.created) {
          emit(DeleteAddressSuccessState());
        } else {
          emit(DeleteAddressErrorState(message: body['message']));
        }
      } catch (err) {
        debugPrint(
            "[ShippingAddressBloc] DeleteAddressEvent error => ${err.toString()}");
        emit(DeleteAddressErrorState(
          message: err.toString(),
        ));
      }
    });

    on<AddNewAddressEvent>((event, emit) async {
      try {
        emit(ShippingAddressLoadingState());
        var response = await shippingAddressRepository.addNewAddress(
            title: event.title,
            receiver: event.receiver,
            address: event.address,
            phoneNumber: event.phoneNumber);
        final body = jsonDecode(response.body);
        if (response.statusCode == HttpStatus.created) {
          emit(AddNewAddressSuccessState());
        } else {
          emit(AddNewAddressErrorState(message: body['message']));
        }
      } catch (err) {
        debugPrint(
            "[ShippingAddressBloc] AddNewAddressEvent error => ${err.toString()}");
        emit(AddNewAddressErrorState(
          message: err.toString(),
        ));
      }
    });

    on<UpdateAddressEvent>((event, emit) async {
      try {
        emit(ShippingAddressLoadingState());
        var response = await shippingAddressRepository.updateAddress(
            shippingAddressId: event.shippingAddressId,
            title: event.title,
            receiver: event.receiver,
            address: event.address,
            phoneNumber: event.phoneNumber);
        final body = jsonDecode(response.body);
        if (response.statusCode == HttpStatus.created) {
          emit(UpdateAddressSuccessState());
        } else {
          emit(UpdateAddressErrorState(message: body['message']));
        }
      } catch (err) {
        debugPrint(
            "[ShippingAddressBloc] UpdateAddressEvent error => ${err.toString()}");
        emit(UpdateAddressErrorState(
          message: err.toString(),
        ));
      }
    });
  }
}
