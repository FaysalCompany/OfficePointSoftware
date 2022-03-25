import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:v2/app/source.dart';
import 'package:v2/persistence/database.dart';
import 'package:v2/persistence/model/model_pause.dart';
import 'package:v2/utils/constants.dart';

part 'pause_event.dart';
part 'pause_state.dart';

class PauseBloc extends Bloc<PauseEvent, PauseState> {
  PauseBloc() : super(PauseInitial());
  List<dynamic> data = [];

  @override
  Stream<PauseState> mapEventToState(
    PauseEvent event,
  ) async* {
    if (event is PauseSend) {
      yield PauseInitial();
      bool connect = await connectionState().whenComplete(() => null);
      if (connect) {
        yield PauseLoading();
        var data = await DataSource.getInstance.sendPause(data: event.data);
        this.data = data;
        if (data.length > 0) {
          yield PauseSucces(message: data);
        } else {
          yield PauseIsEmpty();
        }
      } else {
        var time = DateTime.now().toString().substring(11, 19);
        var date = DateTime.now().toString().substring(0, 10);
        var element = await initList(
            query:
                "SELECT * FROM agents inner join pause ON pause.codeAgent=agents.id WHERE id='${event.data['scan']}' AND pause.dateAdd=CURRENT_DATE");
        if (event.data['scan'] != null) {
          if (element.length > 0) {
            await update(
                sql:
                    "UPDATE pause SET sortie='${time}' WHERE dateAdd=CURRENT_DATE AND codeAgent='${event.data['scan']}'");
          } else {
            var index = await initList(
                query: "SELECT COALESCE(MAX(code),0)+1 as code FROM pause");
            var pause = ModelPause(
              dateAdd: date,
              entree: time,
              code: "${index[0]['code']}",
              sortie: '00:00:00',
              codeAgent: event.data['scan'],
              interTime: '0',
              type: event.data['type'],
              codeEntrep: event.data['refEntreprise'],
              synchro: '0',
            );
            await insert(object: pause.toJson(), table: "pause");
          }
        }
        var ele = await initList(
            query:
                "SELECT * FROM pause p INNER JOIN agents a ON a.id=p.codeAgent WHERE DATE(p.dateAdd)=CURRENT_DATE AND p.type='${event.data['type']}'");
        print(ele);
        this.data = ele;
        if (this.data.length > 0) {
          yield PauseSucces(message: this.data);
        } else {
          yield PauseIsEmpty();
        }
      }
    }
  }
}
