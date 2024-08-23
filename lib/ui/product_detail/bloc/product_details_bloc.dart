import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/products_model.dart';
import '../../../services/dio_client.dart';
import '../../../services/end_point.dart';
import '../../../utils/app_exception.dart';
import '../../../utils/debug.dart';
import '../../cart/view/cart_screen.dart';

part 'product_details_event.dart';

part 'product_details_state.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc() : super(const ProductDetailsState()) {
    on<GetProductDetail>(_onGetProductDetails);
    on<GetAllProduct>(_getAllProductByCategory);
    on<IncrementItem>(_incrementItemCount);
    on<DecrementItem>(_decrementItemCount);
    on<SelectedColour>(_selectedColour);
    on<SelectedSizeIndex>(_selectedSize);
    on<ItemAddToCart>(_addToCart);
  }

  Future<void> _onGetProductDetails(GetProductDetail event, Emitter<ProductDetailsState> emit) async {
    emit(state.copyWith(productStatus: ProductStatus.productLoading));
    await getProductDetails(event, emit);
  }

  getProductDetails(GetProductDetail event, Emitter<ProductDetailsState> emit) async {
    try {
      Response response = await DioClient.shared.get("${EndPoint.allProducts}/${event.productId}");
      if (response.statusCode == 200) {
        Products product = Products.fromJson(response.data as Map<String, dynamic>);
        emit(state.copyWith(productStatus: ProductStatus.productSuccess, product: product));
        if (event.context.mounted) event.context.read<ProductDetailsBloc>().add(GetAllProduct(product.id!, product.category!));
      } else {
        var res = response.data;
        try {
          emit(
            state.copyWith(productStatus: ProductStatus.productFailure, errorMessage: res.toString()),
          );
        } catch (e) {
          Debug.printLog(e.toString());
          emit(
            state.copyWith(
              productStatus: ProductStatus.productFailure,
              errorMessage: "Something Went Wrong3",
            ),
          );
        }
      }
    } on AppException catch (exception) {
      var res = exception.message;
      emit(
        state.copyWith(
          productStatus: ProductStatus.productFailure,
          errorMessage: res.toString(),
        ),
      );
    } catch (e) {
      Debug.printLog(e.toString());
      emit(
        state.copyWith(
          productStatus: ProductStatus.productFailure,
          errorMessage: "Something Went Wrong4",
        ),
      );
    }
  }

  Future<void> _getAllProductByCategory(GetAllProduct event, Emitter<ProductDetailsState> emit) async {
    emit(state.copyWith(categoryStatus: ProductStatus.categoryLoading));
    // await Future.delayed(const Duration(seconds: 2));
    await getAllProductApiCall(event, emit);
  }

  Future<void> getAllProductApiCall(GetAllProduct event, Emitter<ProductDetailsState> emit) async {
    try {
      Response response = await DioClient.shared.get("${EndPoint.allCategoriesProduct}${event.category}");
      if (response.statusCode == 200) {
        List<Products> products = productsFromJson(jsonEncode(response.data));
        products.removeWhere((product) => product.id == event.productId);
        emit(state.copyWith(categoryStatus: ProductStatus.categorySuccess, products: products));
      } else {
        var res = response.data;
        try {
          emit(
            state.copyWith(categoryStatus: ProductStatus.categoryFailure, errorMessage: res.toString()),
          );
        } catch (e) {
          Debug.printLog(e.toString());
          emit(
            state.copyWith(
              categoryStatus: ProductStatus.categoryFailure,
              errorMessage: "Something Went Wrong3",
            ),
          );
        }
      }
    } on AppException catch (exception) {
      var res = exception.message;
      emit(
        state.copyWith(
          categoryStatus: ProductStatus.categoryFailure,
          errorMessage: res.toString(),
        ),
      );
    } catch (e) {
      Debug.printLog(e.toString());
      emit(
        state.copyWith(
          categoryStatus: ProductStatus.categoryFailure,
          errorMessage: "Something Went Wrong4",
        ),
      );
    }
  }

  FutureOr<void> _incrementItemCount(IncrementItem event, Emitter<ProductDetailsState> emit) {
    emit(state.copyWith(itemCount: event.itemCount + 1));
  }

  FutureOr<void> _decrementItemCount(DecrementItem event, Emitter<ProductDetailsState> emit) {
    if (event.itemCount > 0) {
      emit(state.copyWith(itemCount: event.itemCount - 1));
    }
  }

  FutureOr<void> _selectedColour(SelectedColour event, Emitter<ProductDetailsState> emit) {
    emit(state.copyWith(selectedColour: event.itemIndex));
  }

  FutureOr<void> _selectedSize(SelectedSizeIndex event, Emitter<ProductDetailsState> emit) {
    emit(state.copyWith(selectedSize: event.itemIndex));
  }

  FutureOr<void> _addToCart(ItemAddToCart event, Emitter<ProductDetailsState> emit) {

  }
}
