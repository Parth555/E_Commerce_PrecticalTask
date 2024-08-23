
import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/products_model.dart';
import '../../../services/dio_client.dart';
import '../../../services/end_point.dart';
import '../../../utils/app_exception.dart';
import '../../../utils/debug.dart';

part 'category_products_event.dart';
part 'category_products_state.dart';

class CategoryProductsBloc extends Bloc<CategoryProductsEvent, CategoryProductsState> {
  CategoryProductsBloc() : super(const CategoryProductsState()) {
    on<GetAllProduct>(_getAllProductByCategory);
  }

  Future<void> _getAllProductByCategory(GetAllProduct event, Emitter<CategoryProductsState> emit) async {
    emit(state.copyWith(categoryStatus: CategoryStatus.categoryLoading));
    // await Future.delayed(const Duration(seconds: 2));
    await getAllProductApiCall(event, emit);
  }

  Future<void> getAllProductApiCall(GetAllProduct event, Emitter<CategoryProductsState> emit) async {
    try {
      Response response = await DioClient.shared.get("${EndPoint.allCategoriesProduct}${event.category}");
      if (response.statusCode == 200) {
        List<Products> products = productsFromJson(jsonEncode(response.data));
        emit(state.copyWith(categoryStatus: CategoryStatus.categorySuccess, products: products));
      } else {
        var res = response.data;
        try {
          emit(
            state.copyWith(categoryStatus: CategoryStatus.categoryFailure, errorMessage: res.toString()),
          );
        } catch (e) {
          Debug.printLog(e.toString());
          emit(
            state.copyWith(
              categoryStatus: CategoryStatus.categoryFailure,
              errorMessage: "Something Went Wrong3",
            ),
          );
        }
      }
    } on AppException catch (exception) {
      var res = exception.message;
      emit(
        state.copyWith(
          categoryStatus: CategoryStatus.categoryFailure,
          errorMessage: res.toString(),
        ),
      );
    } catch (e) {
      Debug.printLog(e.toString());
      emit(
        state.copyWith(
          categoryStatus: CategoryStatus.categoryFailure,
          errorMessage: "Something Went Wrong4",
        ),
      );
    }
  }
}
