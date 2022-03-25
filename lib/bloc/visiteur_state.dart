part of 'visiteur_bloc.dart';

abstract class VisiteurState extends Equatable {
  const VisiteurState();

  @override
  List<Object> get props => [];
}

class VisiteurInitial extends VisiteurState {}

class VisiteurLoading extends VisiteurState {}

class VisiteurLoaded extends VisiteurState {}

class VisiteurFailed extends VisiteurState {}

class VisiteurProgress extends VisiteurState {}

class VisiteurSucces extends VisiteurState {
  final data;
  VisiteurSucces({this.data});
}

class VisiteurConnected extends VisiteurState {}

class VisiteurError extends VisiteurState {
  final msg;
  VisiteurError({this.msg});
}
