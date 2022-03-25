import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:v2/app/source.dart';
import 'package:v2/persistence/database.dart';
import 'package:v2/persistence/model/model_agent.dart';
import 'package:v2/utils/constants.dart';

part 'identify_event.dart';
part 'identify_state.dart';

class IdentifyBloc extends Bloc<IdentifyEvent, IdentifyState> {
  IdentifyBloc() : super(IdentifyInitial());
  List replay = <String>[];

  @override
  Stream<IdentifyState> mapEventToState(
    IdentifyEvent event,
  ) async* {
    if (event is IdentifySend) {
      try {
        yield IdentifyPregress();
        bool connect = await connectionState().whenComplete(() => null);
        if (connect) {
          var resultat =
              await DataSource.getInstance.identifiedSave(data: event.data);

          if (resultat != null) {
            yield IdentifySucces(resultat);
          }
        } else {
          var type = await initList(
              query:
                  "SELECT * FROM type_agent WHERE designation='${event.data['type']}' AND codeEntrep='${event.data['codeEntrep'].toString().trim()}'");
          var fonction = await initList(
              query:
                  "SELECT * FROM fonction WHERE designation='${event.data['codeFonction']}' AND codeEntrep='${event.data['codeEntrep'].toString().trim()}'");
          var agent = ModelAgent(
            id: event.data['id'],
            adresse: event.data['adresse'],
            codeAgence: event.data['codeAgence'],
            codeEntrep: event.data['codeEntrep'],
            codeFonction: fonction[0]['code'],
            codeUser: event.data['codeUser'],
            dateAdd: DateTime.now().toString(),
            dateNaiss: event.data['dateNaiss'],
            email: event.data['email'],
            password: '0000',
            etat: '0',
            image: event.data['image'],
            nom: event.data['name'],
            sexe: event.data['sexe'],
            synchro: '0',
            tel: event.data['tel'],
            type: '${type[0]['code']}',
          );

          var status = await saveData(model: agent.toJson(), table: "agents");

          if (status > 0) {
            yield IdentifySucces(null);
          }
        }
      } catch (e) {
        yield IdentifyFailed();
      }
    }
    if (event is IdentifyFetch) {
      yield IdentifyInitial();
      bool connect = await connectionState().whenComplete(() => null);
      if (connect) {
        yield IdentifyLoading();
        var resultat = await DataSource.getInstance.initFetchVisiteur();
        replay = resultat;
        if (resultat.length > 0) {
          yield IdentifyLoaded();
        } else {
          yield IdentifyIsEmpty();
        }
      } else {
        yield IdentifyInitial();
        var element = await initList(
            query:
                "SELECT * FROM agents INNER JOIN type_agent ON agents.type=type_agent.code WHERE type_agent.designation<>'VISITEUR'");
        yield IdentifyLoading();
        replay = element;
        if (element.length > 0) {
          yield IdentifyLoaded();
        } else {
          yield IdentifyIsEmpty();
        }
      }
    }
  }
}
