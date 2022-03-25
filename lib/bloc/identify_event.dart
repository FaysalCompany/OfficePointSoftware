part of 'identify_bloc.dart';

abstract class IdentifyEvent extends Equatable {
  const IdentifyEvent();

  @override
  List<Object> get props => [];
}

class IdentifySend extends IdentifyEvent {
  final data;
  IdentifySend(this.data);
}

class IdentifyFetch extends IdentifyEvent {}
