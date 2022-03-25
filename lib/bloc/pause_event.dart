part of 'pause_bloc.dart';

abstract class PauseEvent extends Equatable {
  const PauseEvent();

  @override
  List<Object> get props => [];
}

class PauseSend extends PauseEvent {
  final data;
  PauseSend({this.data});
}
