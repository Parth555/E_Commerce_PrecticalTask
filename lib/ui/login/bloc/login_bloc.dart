import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import '../../../services/dio_client.dart';
import '../../../services/end_point.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_exception.dart';
import '../../../utils/debug.dart';
import '../../../utils/params.dart';
import '../../../utils/preference.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }


  Future<FutureOr<void>> _onLoginButtonPressed(LoginButtonPressed event, Emitter<LoginState> emit) async {
    // show loading
    emit(state.copyWith(status: LoginStatus.loading));


    // Api call
    await Future.delayed(const Duration(seconds: 2));
    await loginAPICall(event.email, password: event.password, emit: emit);
  }

  loginAPICall(String email, {required String password, required Emitter<LoginState> emit}) async {
    try {

      var map = {
        Params.username: 'mor_2314',
        Params.password: "83r5^_",
      };



      Debug.printLoge("loginAPICall PARAMS :::", map.toString());

      Response response = await DioClient.shared.post(EndPoint.login, data: map);

      Debug.printLoge("loginAPICall :::", response.toString());

      if (response.statusCode == 200) {
        // var res = response.data;
        Preference.shared.setString(Preference.accessToken, "dfjdsfndjkbdgBkk3hk2n");
        emit(state.copyWith(status: LoginStatus.success, loginData: response.toString()));
      } else {
        var res = response.data;
        try {
          emit(
            state.copyWith(
              status: LoginStatus.failure,
              errorMessage: res.toString(),
            ),
          );
        } catch (e) {
          Debug.printLog(e.toString());
          emit(
            state.copyWith(
              status: LoginStatus.failure,
              errorMessage: "Something Went Wrong",
            ),
          );
        }
      }
    } on AppException catch (exception) {
      var res = exception.message;
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: res.toString(),
        ),
      );
    } catch (e) {
      Debug.printLog(e.toString());
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: "Something Went Wrong",
        ),
      );
    }
  }
}
