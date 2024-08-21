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
  LoginBloc() : super(LoginState()) {
    on<EmailTextChanged>(_onEmailTextChanged);
    on<PasswordTextChanged>(_onPasswordTextChanged);
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  FutureOr<void> _onEmailTextChanged(EmailTextChanged event, Emitter<LoginState> emit) {
    // Login Controller
    if (event.value.isNotEmpty) {
      emit(
        state.copyWith(
          emailPrefixIcon: AppAssets.icFillMessage,
          emailBgColor: AppColor.secondaryBackground,
          emailTextColor: AppColor.primary,
        ),
      );
    } else {
      emit(
        state.copyWith(
          emailPrefixIcon: AppAssets.icUnFillMessage,
          emailBgColor: AppColor.bgGrey,
          emailTextColor: AppColor.txtGrey,
        ),
      );
    }
  }

  FutureOr<void> _onPasswordTextChanged(PasswordTextChanged event, Emitter<LoginState> emit) {
    if (event.value.isNotEmpty) {
      emit(
        state.copyWith(
          passPrefixIcon: AppAssets.icFillMessage,
          passBgColor: AppColor.secondaryBackground,
          passTextColor: AppColor.primary,
        ),
      );
    } else {
      emit(
        state.copyWith(
          passPrefixIcon: AppAssets.icUnFillMessage,
          passBgColor: AppColor.bgGrey,
          passTextColor: AppColor.txtGrey,
        ),
      );
    }
  }

  Future<FutureOr<void>> _onLoginButtonPressed(LoginButtonPressed event, Emitter<LoginState> emit) async {
    // show loading
    emit(state.copyWith(status: LoginStatus.loading));
    // 1. Validation
    /* final validationError = _validateEmail(event.email, password: event.password);
    // 2. Error send
    if (validationError != null) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: validationError,
        ),
      );
    }*/

    // Api call
    await Future.delayed(const Duration(seconds: 2));
    await loginAPICall(event.email, password: event.password, emit: emit);
  }

  loginAPICall(String email, {required String password, required Emitter<LoginState> emit}) async {
    try {
      // Debug.printLog(loginDataModel.toJson().toString());

      FormData formData = FormData.fromMap({
        Params.username: email,
        Params.password: password,
      });

      var map = {};

      for (var element in formData.fields) {
        map.putIfAbsent(element.key, () => element.value);
      }

      Debug.printLoge("loginAPICall PARAMS :::", map.toString());

      Response response = await DioClient.shared.post(EndPoint.login, data: formData);

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
