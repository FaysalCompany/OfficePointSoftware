part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {}

class LoginFailed extends LoginState {}

class LoginProgress extends LoginState {}

class LoginConnected extends LoginState {}

class LoginSessesion extends LoginState {
  final resultat;
  LoginSessesion({this.resultat});
}

class LoginSucces extends LoginState {
  final resultat;
  LoginSucces(this.resultat);
}
