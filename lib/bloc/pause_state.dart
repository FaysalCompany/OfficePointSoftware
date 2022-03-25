part of 'pause_bloc.dart';

abstract class PauseState extends Equatable {
  const PauseState();

  @override
  List<Object> get props => [];
}

class PauseInitial extends PauseState {}

class PauseLoading extends PauseState {}

class PauseLoaded extends PauseState {}

class PauseConnected extends PauseState {}

class PausePresse extends PauseState {}

class PauseSucces extends PauseState {
  final message;
  PauseSucces({this.message});
}

class PauseFailed extends PauseState {}

class PauseIsEmpty extends PauseState {}
