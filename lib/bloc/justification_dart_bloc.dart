import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:v2/app/source.dart';
import 'package:v2/utils/constants.dart';

part 'justification_dart_event.dart';
part 'justification_dart_state.dart';

class JustificationDartBloc
    extends Bloc<JustificationDartEvent, JustificationDartState> {
  JustificationDartBloc() : super(JustificationDartInitial());

  @override
  Stream<JustificationDartState> mapEventToState(
    JustificationDartEvent event,
  ) async* {
    if (event is JustificationDartSave) {
      yield JustificationDartInitial();
      bool connect = await connectionState().whenComplete(() => null);
      if (connect) {
        var resultat =
            await DataSource.getInstance.justificaSave(data: event.data);
        print("------------------------------------${resultat}");
        if (resultat == '1') {
          yield JustificationDartLoaded();
        } else {
          yield JustificationDartFailed();
        }
      } else {
        yield JustificationDartConnected();
      }
    }
  }
}
