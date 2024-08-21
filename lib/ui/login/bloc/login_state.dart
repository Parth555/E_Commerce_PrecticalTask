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
    this.emailPrefixIcon = AppAssets.icUnFillMessage,
    this.emailBgColor = AppColor.bgGrey,
    this.emailTextColor = AppColor.bgGrey,
    this.passPrefixIcon = AppAssets.icUnFillMessage,
    this.passBgColor = AppColor.bgGrey,
    this.passTextColor = AppColor.bgGrey,
  });

  final LoginStatus status;
  final String errorMessage;
  final String loginData;

  final String emailPrefixIcon;
  final Color emailBgColor;
  final Color emailTextColor;

  final String passPrefixIcon;
  final Color passBgColor;
  final Color passTextColor;

  LoginState copyWith({
    LoginStatus? status,
    String? errorMessage,
    String? loginData,
    String? emailPrefixIcon,
    Color? emailBgColor,
    Color? emailTextColor,
    String? passPrefixIcon,
    Color? passBgColor,
    Color? passTextColor,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      loginData: loginData ?? this.loginData,
      emailPrefixIcon: emailPrefixIcon ?? this.emailPrefixIcon,
      emailBgColor: emailBgColor ?? this.emailBgColor,
      emailTextColor: emailTextColor ?? this.emailTextColor,
      passPrefixIcon: passPrefixIcon ?? this.passPrefixIcon,
      passBgColor: passBgColor ?? this.passBgColor,
      passTextColor: passTextColor ?? this.passTextColor,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        loginData,
        emailPrefixIcon,
        emailBgColor,
        emailTextColor,
        passPrefixIcon,
        passBgColor,
        passTextColor,
      ];
}
