
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/dio_client.dart';
import '../../../services/end_point.dart';
import '../../../utils/app_exception.dart';
import '../../../utils/debug.dart';
import '../../../utils/params.dart';
import '../../../utils/preference.dart';

part 'signup_event.dart';
part 'signup_state.dart';


class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(const SignupState()) {
    on<SignUpButtonPressed>(_onSignUpButtonPressed);
  }

  Future<void> _onSignUpButtonPressed(SignUpButtonPressed event, Emitter<SignupState> emit) async {

    // show loading
    emit(state.copyWith(status: SignUpStatus.loading));


    // Api call
    await Future.delayed(const Duration(seconds: 2));
    await signUpAPICall(email: event.email,userName: event.userName, password: event.password, emit: emit);
  }

  signUpAPICall({required String email, required String userName, required String password, required Emitter<SignupState> emit}) async {

    try {

      var map = {
        Params.email: email,
        Params.username: userName,
        Params.password: password,
      };



      Debug.printLoge("loginAPICall PARAMS :::", map.toString());

      Response response = await DioClient.shared.post(EndPoint.signUp, data: map);

      Debug.printLoge("loginAPICall :::", response.toString());

      if (response.statusCode == 200) {
        // var res = response.data;
        Preference.shared.setString(Preference.accessToken, "dfjdsfndjkbdgBkk3hk2n");
        emit(state.copyWith(status: SignUpStatus.success, signUpData: response.toString()));
      } else {
        var res = response.data;
        try {
          emit(
            state.copyWith(
              status: SignUpStatus.failure,
              errorMessage: res.toString(),
            ),
          );
        } catch (e) {
          Debug.printLog(e.toString());
          emit(
            state.copyWith(
              status: SignUpStatus.failure,
              errorMessage: "Something Went Wrong",
            ),
          );
        }
      }
    } on AppException catch (exception) {
      var res = exception.message;
      emit(
        state.copyWith(
          status: SignUpStatus.failure,
          errorMessage: res.toString(),
        ),
      );
    } catch (e) {
      Debug.printLog(e.toString());
      emit(
        state.copyWith(
          status: SignUpStatus.failure,
          errorMessage: "Something Went Wrong",
        ),
      );
    }
  }
}
