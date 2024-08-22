part of 'signup_bloc.dart';


enum SignUpStatus { initial, loading, success, failure, successWithEmpty }

extension SignUpStatusX on SignUpStatus {
  bool get isInitial => this == SignUpStatus.initial;

  bool get isLoading => this == SignUpStatus.loading;

  bool get isSuccess => this == SignUpStatus.success;

  bool get isFailure => this == SignUpStatus.failure;
}

class SignupState extends Equatable {
  const SignupState({
    this.status = SignUpStatus.initial,
    this.errorMessage = '',
    this.signUpData = '',
  });

  final SignUpStatus status;
  final String errorMessage;
  final String signUpData;

  SignupState copyWith({
    SignUpStatus? status,
    String? errorMessage,
    String? signUpData,
  }) {
    return SignupState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      signUpData: signUpData ?? this.signUpData,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    signUpData,
  ];
}

