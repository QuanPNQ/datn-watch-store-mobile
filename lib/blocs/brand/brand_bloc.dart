import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/brand/brand_event.dart';
import 'package:flutter_mob/blocs/brand/brand_state.dart';
import 'package:flutter_mob/models/brand/brand.dart';
import 'package:flutter_mob/repositories/brand/brand_repository.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  final BrandRepository brandRepository;

  BrandBloc({required this.brandRepository}) : super(BrandInitialState()) {
    on<GetListBrandEvent>((event, emit) async {
      try {
        emit(BrandLoadingState(isViewAll: event.isViewAll));
        var response = await brandRepository.getListBrand(
            page: event.page, limit: event.limit);
        final body = jsonDecode(response.body);
        if (response.statusCode == HttpStatus.ok) {
          final brands = body['data']['brands'];
          List<Brand> listBrand =
              List<Brand>.from(brands.map((item) => Brand.fromJson(item)))
                  .toList();
          emit(GetBrandSuccessState(
              listBrand: listBrand, isViewAll: event.isViewAll));
        } else {
          emit(BrandErrorState(
              message: body['message'], isViewAll: event.isViewAll));
        }
      } catch (err) {
        debugPrint(
            "[BrandBloc] GetListBrandEventEvent error => ${err.toString()}");
        emit(BrandErrorState(
            message: err.toString(), isViewAll: event.isViewAll));
      }
    });
  }
}
