part of 'justification_dart_bloc.dart';

abstract class JustificationDartEvent extends Equatable {
  const JustificationDartEvent();

  @override
  List<Object> get props => [];
}

class JustificationDartSave extends JustificationDartEvent {
  final data;
  JustificationDartSave({this.data});
}

class JustificationUpdate extends JustificationDartEvent {
  final data;
  JustificationUpdate(this.data);
}
