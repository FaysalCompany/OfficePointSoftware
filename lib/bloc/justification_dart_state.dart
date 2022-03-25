part of 'justification_dart_bloc.dart';

abstract class JustificationDartState extends Equatable {
  const JustificationDartState();

  @override
  List<Object> get props => [];
}

class JustificationDartInitial extends JustificationDartState {}

class JustificationDartLoading extends JustificationDartState {}

class JustificationDartLoaded extends JustificationDartState {}

class JustificationDartConnected extends JustificationDartState {}

class JustificationDartIsEmpty extends JustificationDartState {}

class JustificationDartFailed extends JustificationDartState {}
