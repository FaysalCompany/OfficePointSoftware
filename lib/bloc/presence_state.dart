part of 'presence_bloc.dart';

abstract class PresenceState extends Equatable {
  const PresenceState();

  @override
  List<Object> get props => [];
}

class PresenceInitial extends PresenceState {}

class PresenceLoading extends PresenceState {}

class PresenceLoaded extends PresenceState {}

class PresenceConnected extends PresenceState {}

class PresencePregress extends PresenceState {}

class PresenceSucces extends PresenceState {
  final data;
  PresenceSucces({this.data});
}

class PresenceVisiteur extends PresenceState {
  final idVisiteur;
  final code;
  PresenceVisiteur({this.code, this.idVisiteur});
}

class PresenceFailed extends PresenceState {}

class PresenceIsEmpty extends PresenceState {}

class PresenceLoadcbx extends PresenceState {}

class PresenceInitiaList extends PresenceState {}

class PresenceConnectedList extends PresenceState {}

class PresenceLoadingList extends PresenceState {}

class PresenceisEmptyList extends PresenceState {}

class PresenceLoadLoadedList extends PresenceState {}

class PresenceConfirmation extends PresenceState {}
