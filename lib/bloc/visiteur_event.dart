part of 'visiteur_bloc.dart';

abstract class VisiteurEvent extends Equatable {
  const VisiteurEvent();

  @override
  List<Object> get props => [];
}

class VisiteurSave extends VisiteurEvent {
  final data;
  VisiteurSave(this.data);
}
