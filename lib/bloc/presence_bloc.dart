import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:v2/app/source.dart';
import 'package:v2/persistence/database.dart';
import 'package:v2/persistence/model/model_presence.dart';
import 'package:v2/utils/constants.dart';
part 'presence_event.dart';
part 'presence_state.dart';

class PresenceBloc extends Bloc<PresenceEvent, PresenceState> {
  PresenceBloc() : super(PresenceInitial());
  List desplay = [];
  List desplayF = [];
  List desplayT = [];
  List desplayA = [];
  List replayData = <String>[];
  List replay = <dynamic>[];
  static DataSource insta;
  @override
  Stream<PresenceState> mapEventToState(
    PresenceEvent event,
  ) async* {
    if (event is PresencesendData) {
      yield PresencePregress();
      bool connect = await connectionState().whenComplete(() => null);
      if (connect) {
        yield PresenceLoading();
        var value = await DataSource.getInstance.identifySnan(data: event.data);
        var data = value[0]['data'];
        if (value[0]['data'].length > 0) {
          if (data[0]['type'] == 'VISITEUR') {
            yield PresenceVisiteur(
              idVisiteur: data[0]['id'],
              code: data[0]['code'],
            );
          } else {
            yield PresenceSucces(data: value[0]['data']);
          }
        } else {
          yield PresenceIsEmpty();
        }
      } else {
        var time = DateTime.now().toString().substring(11, 19);
        yield PresenceLoading();
        var element = await initList(
            query:
                "SELECT * FROM agents inner join presences ON presences.codeAgent=agents.id WHERE id='${event.data['barcode']}' AND presences.dateAdd=CURRENT_DATE");
        print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%> ${element}");
        if (element.length > 0) {
          await update(
              sql:
                  "UPDATE presences SET sortie='${time}' WHERE dateAdd=CURRENT_DATE AND codeAgent='${event.data['barcode']}'");
        } else {
          var presence = ModelPresenceLocal(
            codeAgent: event.data['barcode'],
            codeAgence: event.data['codeAgence'],
            synchro: '0',
            entree: DateTime.now().toString().substring(11, 19),
            sortie: '00:00:00',
            jour: event.data['jour'],
            dateAdd: DateTime.now().toString().substring(0, 10),
          );
          await insert(
            object: presence.toJson(),
            table: "presences",
          );
        }

        var elment = await initList(
          query:
              "SELECT * FROM agents INNER JOIN presences ON presences.codeAgent=agents.id WHERE id='${event.data['barcode']}' AND presences.dateAdd=CURRENT_DATE",
        );
        if (elment.length > 0) {
          yield PresenceSucces(data: elment);
        } else {
          yield PresenceIsEmpty();
        }
        // yield PresenceConnected();
      }
    }
    if (event is Presencechargecbx) {
      yield PresenceInitial();
      bool connect = await connectionState().whenComplete(() => null);
      if (connect) {
        var rstA =
            await DataSource.getInstance.chargeComboxAgent(event: event.id);
        var rst = await DataSource.getInstance.chargeCombox(event: event.id);
        var rstF =
            await DataSource.getInstance.chargeComboxFonction(event: event.id);
        var rstT =
            await DataSource.getInstance.chargeComboxType(event: event.id);
        yield PresenceLoading();
        desplayA = rstA;
        desplay = rst;
        desplayT = rstT;
        desplayF = rstF;
        if (rst != null) {
          yield PresenceLoadcbx();
        }
      } else {
        yield PresenceInitial();
        var rstd = await loadCombox(
            sql:
                "SELECT nom AS element FROM agents INNER JOIN type_agent ON agents.type=type_agent.code WHERE  (type_agent.designation<>'VISITEUR' AND type_agent.codeEntrep=${event.id}) ORDER BY nom");
        var rst = await loadComb(
            sql: "SELECT * FROM agences WHERE codeEntrep=${event.id}");
        var rstF = await loadCombox(
            sql:
                "SELECT DISTINCT designation as element FROM fonction WHERE codeEntrep=${event.id}");
        var rstT = await loadCombox(
            sql:
                "SELECT  designation as element FROM type_agent WHERE (designation<>'VISITEUR' AND type_agent.codeEntrep=${event.id})");
        yield PresenceLoading();
        desplayA = rstd;
        desplay = rst;
        desplayT = rstT;
        desplayF = rstF;
        if (rst != null) {
          yield PresenceLoadcbx();
        }

        // yield PresenceConnected();
      }
    }

    if (event is Presencecharge) {
      yield PresenceInitiaList();
      bool connect = await connectionState().whenComplete(() => null);
      if (connect) {
        yield PresenceLoadingList();
        var rst =
            await DataSource.getInstance.fetchPresence(data: event.refAgence);
        this.replay = rst;
        print(rst);
        if (replay.length > 0) {
          yield PresenceLoadLoadedList();
        } else {
          yield PresenceisEmptyList();
        }
      } else {
        var element = await initList(
            query:
                "SELECT * FROM agents INNER JOIN presences ON agents.id=presences.codeAgent WHERE presences.dateAdd=CURRENT_DATE");
        this.replay = element;
        if (replay.length > 0) {
          yield PresenceLoadLoadedList();
        } else {
          yield PresenceisEmptyList();
        }
        // yield PresenceConnectedList();
      }
    }
  }
}
