part of 'identify_bloc.dart';

abstract class IdentifyState extends Equatable {
  const IdentifyState();

  @override
  List<Object> get props => [];
}

class IdentifyInitial extends IdentifyState {}

class IdentifyLoading extends IdentifyState {}

class IdentifyLoaded extends IdentifyState {}

class IdentifyConnected extends IdentifyState {}

class IdentifyIsEmpty extends IdentifyState {}

class IdentifyFailed extends IdentifyState {}

class IdentifyPregress extends IdentifyState {}

class IdentifySucces extends IdentifyState {
  final message;
  IdentifySucces(this.message);
}
