import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/product/product_event.dart';
import 'package:flutter_mob/blocs/product/product_state.dart';
import 'package:flutter_mob/models/watch/watch.dart';
import 'package:flutter_mob/repositories/product/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository})
      : super(ProductInitialState()) {
    on<GetClassicProductEvent>((event, emit) async {
      try {
        emit(GetClassicProductLoadingState());
        var response = await productRepository.getListProduct(
            type: event.type, page: event.page, limit: event.limit);
        emit(ProductInitialState());
        final body = jsonDecode(response.body);
        if (response.statusCode == HttpStatus.created) {
          final data = body['data'];
          List<Watch> listWatch =
              List<Watch>.from(data.map((item) => Watch.fromJson(item)))
                  .toList();
          emit(GetClassicProductSuccessState(
              type: event.type, listWatch: listWatch));
        } else {
          emit(GetClassicProductErrorState(message: body['message']));
        }
      } catch (err) {
        debugPrint(
            "[ProductBloc] GetClassicProductEvent error => ${err.toString()}");
        emit(GetClassicProductErrorState(message: err.toString()));
      }
    });

    on<GetTopDeelProductEvent>((event, emit) async {
      try {
        emit(GetTopDeelProductLoadingState(isViewAll: event.isViewAll));
        var response = await productRepository.getListProduct(
            type: event.type, page: event.page, limit: event.limit);
        emit(ProductInitialState());
        final body = jsonDecode(response.body);
        if (response.statusCode == HttpStatus.created) {
          final data = body['data'];
          List<Watch> listWatch =
              List<Watch>.from(data.map((item) => Watch.fromJson(item)))
                  .toList();
          emit(GetTopDeelProductSuccessState(
              listWatch: listWatch, isViewAll: event.isViewAll));
        } else {
          emit(GetTopDeelProductErrorState(
              message: body['message'], isViewAll: event.isViewAll));
        }
      } catch (err) {
        debugPrint(
            "[ProductBloc] GetTopDeelProductEvent error => ${err.toString()}");
        emit(GetTopDeelProductErrorState(
            message: err.toString(), isViewAll: event.isViewAll));
      }
    });

    on<GetOutstandingProductEvent>((event, emit) async {
      try {
        emit(GetOutstandingProductLoadingState(isViewAll: event.isViewAll));
        var response = await productRepository.getListProduct(
            page: event.page, limit: event.limit);
        final body = jsonDecode(response.body);
        if (response.statusCode == HttpStatus.created) {
          final data = body['data'];
          List<Watch> listWatch =
              List<Watch>.from(data.map((item) => Watch.fromJson(item)))
                  .toList();
          emit(GetOutstandingProductSuccessState(
              listWatch: listWatch, isViewAll: event.isViewAll));
        } else {
          emit(GetOutstandingProductErrorState(
              message: body['message'], isViewAll: event.isViewAll));
        }
      } catch (err) {
        debugPrint(
            "[ProductBloc] GetOutstandingProductEvent error => ${err.toString()}");
        emit(GetOutstandingProductErrorState(
            message: err.toString(), isViewAll: event.isViewAll));
      }
    });
  }
}
