part of 'presence_bloc.dart';

abstract class PresenceEvent extends Equatable {
  const PresenceEvent();

  @override
  List<Object> get props => [];
}

class PresencesendData extends PresenceEvent {
  final data;
  PresencesendData({this.data});
}

class Presencechargecbx extends PresenceEvent {
  final id;
  Presencechargecbx({this.id});
}

class Presencecharge extends PresenceEvent {
  final refAgence;
  Presencecharge({this.refAgence});
}
