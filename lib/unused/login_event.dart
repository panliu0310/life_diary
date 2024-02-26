part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {

  const LoginButtonPressed();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginButtonPressed { email: , password:  }';
}