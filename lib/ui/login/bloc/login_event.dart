part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {}

class EmailTextChanged extends LoginEvent {
  EmailTextChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

class PasswordTextChanged extends LoginEvent {
  PasswordTextChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

class LoginButtonPressed extends LoginEvent {
  LoginButtonPressed(this.email, this.password);

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
