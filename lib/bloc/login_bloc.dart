import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:v2/app/source.dart';
import 'package:v2/persistence/database.dart';
import 'package:v2/persistence/model/model_user.dart';
import 'package:v2/utils/constants.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginSing) {
      yield LoginProgress();
      bool connect = await connectionState().whenComplete(() => null);
      if (connect) {
        var resultat = await DataSource.getInstance.initLogin(data: event.data);
        print("-------------------------> ${resultat}");
        if (resultat != null) {
          var user = ModelUser(
            adresse: resultat[0]['adresse'],
            code: resultat[0]['code'],
            codeAgence: resultat[0]['codeAgence'],
            codeEntrep: resultat[0]['codeEntrep'],
            codeValidation: resultat[0]['codeValidation'],
            dateAdd: resultat[0]['dateAdd'],
            email: resultat[0]['email'],
            etat: resultat[0]['etat'],
            fonction: resultat[0]['fonction'],
            logo: resultat[0]['logo'],
            nom: resultat[0]['nom'],
            photo: resultat[0]['photo'],
            psedo: resultat[0]['psedo'],
            siteweb: resultat[0]['siteweb'],
            synchro: resultat[0]['synchro'],
            tel: resultat[0]['tel'],
            type: resultat[0]['type'],
            urlArticles: resultat[0]['urlArticles'],
            pswd: event.data['password'],
          );
          var status = await saveData(model: user.toJson(), table: "users");
          print(
              "LOCAL========CONNEXION REUSSI AVEC SUCCES============> ${status}");
          yield LoginSessesion(resultat: resultat);
          yield LoginSucces(resultat);
        } else {
          print("----------------------->$resultat");
          yield LoginFailed();
        }
      } else {
        yield LoginProgress();
        var resultat = await initLogin(
            "SELECT * FROM users WHERE psedo='${event.data['username'].toString().trim()}' AND pswd='${event.data['password'].toString().trim()}'");
        if (resultat.length > 0) {
          yield LoginSessesion(resultat: resultat);
          yield LoginSucces(resultat);
        } else {
          yield LoginFailed();
        }
        // yield LoginConnected();
      }
    }
  }
}
