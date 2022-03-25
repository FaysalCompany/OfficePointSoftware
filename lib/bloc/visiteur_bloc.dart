import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:v2/app/source.dart';
import 'package:v2/utils/constants.dart';

part 'visiteur_event.dart';
part 'visiteur_state.dart';

class VisiteurBloc extends Bloc<VisiteurEvent, VisiteurState> {
  VisiteurBloc() : super(VisiteurInitial());

  @override
  Stream<VisiteurState> mapEventToState(
    VisiteurEvent event,
  ) async* {
    if (event is VisiteurSave) {
      try {
        yield VisiteurProgress();
        bool connect = await connectionState().whenComplete(() => null);
        if (connect) {
          yield VisiteurLoading();
          var resultat =
              await DataSource.getInstance.identifiedVisiteur(data: event.data);
          print("=========================> ${resultat}");
          if (resultat != null) {
            yield VisiteurSucces(data: resultat);
          } else {
            yield VisiteurFailed();
          }
        } else {
          yield VisiteurConnected();
        }
      } catch (_) {
        yield VisiteurError(msg: _.toString());
      }
    }
  }
}
