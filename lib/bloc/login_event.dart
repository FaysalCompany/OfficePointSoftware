part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginSing extends LoginEvent {
  final data;

  LoginSing(this.data);
}
