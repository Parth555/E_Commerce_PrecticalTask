part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
}

class SignUpButtonPressed extends SignupEvent {
  SignUpButtonPressed(this.email,this.userName, this.password);

  final String email;
  final String userName;
  final String password;

  @override
  List<Object?> get props => [email,userName, password];
}
