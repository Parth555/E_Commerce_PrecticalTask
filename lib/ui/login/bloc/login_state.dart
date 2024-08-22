part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure, successWithEmpty }

extension LoginStatusX on LoginStatus {
  bool get isInitial => this == LoginStatus.initial;

  bool get isLoading => this == LoginStatus.loading;

  bool get isSuccess => this == LoginStatus.success;

  bool get isFailure => this == LoginStatus.failure;
}

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
    this.errorMessage = '',
    this.loginData = '',
  });

  final LoginStatus status;
  final String errorMessage;
  final String loginData;

  LoginState copyWith({
    LoginStatus? status,
    String? errorMessage,
    String? loginData,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      loginData: loginData ?? this.loginData,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        loginData,
      ];
}
