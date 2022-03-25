import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:v2/app/source.dart';
import 'package:v2/persistence/database.dart';
import 'package:v2/persistence/model/model_agence.dart';
import 'package:v2/persistence/model/model_agent.dart';
import 'package:v2/persistence/model/model_fonction.dart';
import 'package:v2/persistence/model/model_pause.dart';
import 'package:v2/persistence/model/model_typeagent.dart';
import 'package:v2/persistence/request.dart';
import 'package:v2/utils/app_theme.dart';

class ViewDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateBody();
  }
}

class _StateBody extends State<ViewDialog> {
  bool compteur = false;
  bool isLoader = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * .3,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(5),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Divider(
                color: Colors.transparent,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 50.0,
                  right: 50.0,
                  bottom: 10,
                ),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: AppTheme.blueColor,
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        !compteur
                            ? Icon(
                                Icons.cloud_download_outlined,
                                color: Colors.white,
                              )
                            : SpinKitCircle(
                                color: Colors.white,
                                size: 30,
                              ),
                        SizedBox(width: 3.0),
                        Text(
                          "Download data",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () async {
                    await initData();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 50.0,
                  right: 50.0,
                  bottom: 10,
                ),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: AppTheme.redColor,
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        !isLoader
                            ? Icon(
                                Icons.cloud_upload_outlined,
                                color: Colors.white,
                              )
                            : SpinKitCircle(
                                color: Colors.white,
                                size: 30,
                              ),
                        SizedBox(
                          width: 3.0,
                        ),
                        Text(
                          "Upload data",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () async {
                    await upload();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> upload() async {
    setState(() {
      isLoader = true;
    });

    await sendPause().then((value) {
      sendPresence().then((value) {
        setState(() {
          isLoader = false;
        });
      });
    });
  }

  Future<void> initData() async {
    setState(() {
      compteur = true;
    });
    await DataSource.getInstance
        .findAll(REQUEST: request_agences)
        .then((data) async {
      for (int index = 0; index < data.length; index++) {
        var agence = ModelAgence(
            code: data[index]['code'],
            codeEntrep: data[index]['codeEntrep'],
            dateAdd: data[index]['dateAdd'],
            id: data[index]['id'],
            nom: data[index]['nom'],
            synchro: '1');
        await saveData(model: agence.toJson(), table: 'agences').then((value) {
          print("--------------------AGENCES----------------------------> 1");
        }).catchError((error) => {
              print(error.toString()),
            });
      }
    });

    await DataSource.getInstance
        .findAll(REQUEST: request_agent)
        .then((data) async {
      for (int index = 0; index < data.length; index++) {
        var agent = ModelAgent(
          code: data[index]['code'],
          codeEntrep: data[index]['codeEntrep'],
          dateAdd: data[index]['dateAdd'],
          id: data[index]['id'],
          nom: data[index]['nom'],
          adresse: data[index]['adresse'],
          codeAgence: data[index]['codeAgence'],
          codeFonction: data[index]['codeFonction'],
          codeUser: data[index]['codeUser'],
          dateNaiss: data[index]['dateNaiss'],
          email: data[index]['email'],
          etat: data[index]['etat'],
          image: "0",
          password: data[index]['password'],
          sexe: data[index]['sexe'],
          tel: data[index]['tel'],
          type: data[index]['type'],
          synchro: '1',
        );
        await saveData(model: agent.toJson(), table: 'agents').then((value) {
          print("-------------------AGENTS-----------------------------> 2");
        }).catchError((error) => {
              print(error.toString()),
            });
      }
    });

    await DataSource.getInstance
        .findAll(REQUEST: request_fonction)
        .then((data) async {
      for (int index = 0; index < data.length; index++) {
        var fonction = ModelFonction(
          code: data[index]['code'],
          codeEntrep: data[index]['codeEntrep'],
          dateAdd: data[index]['dateAdd'],
          designation: data[index]['designation'],
          synchro: '1',
        );
        await saveData(model: fonction.toJson(), table: 'fonction')
            .then((value) {
          print("--------------------------FONCTION----------------------> 3");
        }).catchError((error) => {
                  print(error.toString()),
                });
      }
    });

    // await DataSource.getInstance
    //     .findAll(REQUEST: request_fonction)
    //     .then((data) async {
    //   for (int index = 0; index < data.length; index++) {
    //     var fonction = ModelFonction(
    //       code: data[index]['code'],
    //       codeEntrep: data[index]['codeEntrep'],
    //       dateAdd: data[index]['dateAdd'],
    //       designation: data[index]['designation'],
    //       synchro: '1',
    //     );
    //     await saveData(model: fonction.toJson(), table: 'fonction')
    //         .then((value) {})
    //         .catchError((error) => {
    //               print(error.toString()),
    //             });
    //   }
    // });

    await DataSource.getInstance
        .findAll(REQUEST: request_typeagent)
        .then((data) async {
      for (int index = 0; index < data.length; index++) {
        var pause = ModelTypeagent(
          code: data[index]['code'],
          dateAdd: data[index]['dateAdd'],
          designation: data[index]['designation'],
          codeEntrep: data[index]['codeEntrep'],
          synchro: '1',
        );
        await saveData(model: pause.toJson(), table: 'type_agent')
            .then((value) {
          print("---------------------TYPE-AGENT---------------------> 5");
        }).catchError((error) => {
                  print(error.toString()),
                });
      }
    });

    await DataSource.getInstance
        .findAll(REQUEST: request_pause)
        .then((data) async {
      for (int index = 0; index < data.length; index++) {
        var type = ModelPause(
          code: data[index]['code'],
          dateAdd: data[index]['dateAdd'],
          codeAgent: data[index]['codeAgent'],
          entree: data[index]['entree'],
          interTime: data[index]['interTime'],
          sortie: data[index]['sortie'],
          type: data[index]['type'],
          codeEntrep: data[index]['codeEntrep'],
          synchro: '1',
        );
        await saveData(model: type.toJson(), table: 'pause').then((value) {
          print("-----------------------PAUSE-------------------------> 6");
          setState(() {
            compteur = false;
          });
        }).catchError((error) => {
              print(error.toString()),
            });
      }
    });
  }
}
