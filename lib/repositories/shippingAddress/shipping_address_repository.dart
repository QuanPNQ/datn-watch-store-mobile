import 'package:flutter_mob/service/shipping_address_service.dart';

class ShippingAddressRepository {
  Future<dynamic> getListAddress() async {
    return await ShippingAddressService().getListAddress();
  }

  Future<dynamic> addNewAddress(
      {String? title,
      required String receiver,
      required String address,
      required String phoneNumber}) async {
    return await ShippingAddressService().addNewAddress(
        title: title,
        receiver: receiver,
        address: address,
        phoneNumber: phoneNumber);
  }

  Future<dynamic> setDefaultAddress({required String shippingAddressId}) async {
    return await ShippingAddressService()
        .setDefaultAddress(shippingAddressId: shippingAddressId);
  }

  Future<dynamic> updateAddress(
      {required String shippingAddressId,
      String? title,
      String? receiver,
      String? address,
      String? phoneNumber}) async {
    return await ShippingAddressService().updateAddress(
        shippingAddressId: shippingAddressId,
        title: title,
        receiver: receiver,
        address: address,
        phoneNumber: phoneNumber);
  }

  Future<dynamic> deleteAddress({required String shippingAddressId}) async {
    return await ShippingAddressService()
        .deleteAddress(shippingAddressId: shippingAddressId);
  }
}
