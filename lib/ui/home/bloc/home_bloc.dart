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

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<GetAllCategory>(_onGetAllCategory);
    on<GetAllProduct>(_onGetAllProducts);
  }

  Future<void> _onGetAllCategory(GetAllCategory event, Emitter<HomeState> emit) async {
    emit(state.copyWith(homeStatus: HomeStatus.categoryLoading));
    // await Future.delayed(const Duration(seconds: 2));
    await getAllCategoryApiCall(event, emit);
  }

  Future<void> _onGetAllProducts(GetAllProduct event, Emitter<HomeState> emit) async {
    emit(state.copyWith(homeStatus: HomeStatus.productLoading));
    // await Future.delayed(const Duration(seconds: 2));
    await getAllProductApiCall(event, emit);
  }

  Future<void> getAllCategoryApiCall(GetAllCategory event, Emitter<HomeState> emit) async {
    try {
      Response response = await DioClient.shared.get(EndPoint.allCategories);
      if (response.statusCode == 200) {
        emit(state.copyWith(homeStatus: HomeStatus.categorySuccess, category: categoriesFromJson(jsonEncode(response.data))));
      } else {
        var res = response.data;
        try {
          emit(
            state.copyWith(homeStatus: HomeStatus.categoryFailure, errorMessage: res.toString()),
          );
        } catch (e) {
          Debug.printLog(e.toString());
          emit(
            state.copyWith(
              homeStatus: HomeStatus.categoryFailure,
              errorMessage: "Something Went Wrong 1",
            ),
          );
        }
      }
    } on AppException catch (exception) {
      var res = exception.message;
      emit(
        state.copyWith(
          homeStatus: HomeStatus.categoryFailure,
          errorMessage: res.toString(),
        ),
      );
    } catch (e) {
      Debug.printLog(e.toString());
      emit(
        state.copyWith(
          homeStatus: HomeStatus.categoryFailure,
          errorMessage: "Something Went Wrong2",
        ),
      );
    }
  }

  Future<void> getAllProductApiCall(GetAllProduct event, Emitter<HomeState> emit) async {
    try {
      Response response = await DioClient.shared.get(EndPoint.allProducts);
      if (response.statusCode == 200) {
        List<Products> products = productsFromJson(jsonEncode(response.data));
        emit(state.copyWith(homeStatus: HomeStatus.productSuccess, products: products));
      } else {
        var res = response.data;
        try {
          emit(
            state.copyWith(homeStatus: HomeStatus.productFailure, errorMessage: res.toString()),
          );
        } catch (e) {
          Debug.printLog(e.toString());
          emit(
            state.copyWith(
              homeStatus: HomeStatus.productFailure,
              errorMessage: "Something Went Wrong3",
            ),
          );
        }
      }
    } on AppException catch (exception) {
      var res = exception.message;
      emit(
        state.copyWith(
          homeStatus: HomeStatus.productFailure,
          errorMessage: res.toString(),
        ),
      );
    } catch (e) {
      Debug.printLog(e.toString());
      emit(
        state.copyWith(
          homeStatus: HomeStatus.productFailure,
          errorMessage: "Something Went Wrong4",
        ),
      );
    }
  }
}
