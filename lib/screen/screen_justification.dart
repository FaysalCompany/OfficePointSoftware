import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:v2/bloc/justification_dart_bloc.dart';
import 'package:v2/bloc/presence_bloc.dart';
import 'package:v2/utils/app_theme.dart';
import 'package:v2/utils/mypreferences.dart';
import 'package:v2/utils/widget.dart';

class ScreenJustification extends StatefulWidget {
  final id;
  final code;
  const ScreenJustification({Key key, this.id, this.code}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

// $motif=$data['motif'];
// $id=$data['id'];
// $code=$data['code'];
class _BodyState extends State<ScreenJustification> {
  bool status = false;
  final information = TextEditingController();
  var initBloc;
  var init;
  @override
  void initState() {
    super.initState();
    initBloc = BlocProvider.of<JustificationDartBloc>(context);
    init = BlocProvider.of<PresenceBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BlocListener<JustificationDartBloc, JustificationDartState>(
        listener: (context, state) {
          if (state is JustificationDartInitial) {
            setState(() {
              status = true;
              FocusScope.of(context).requestFocus(FocusNode());
            });
          }
          if (state is JustificationDartConnected) {
            setState(() {
              status = false;
              showTop(
                context: context,
                title: "Veuillez vérifier votre connexion internet",
                color: AppTheme.redColor,
                icon: Icon(
                  FontAwesomeIcons.server,
                  color: Colors.white,
                ),
              );
            });
          }
          if (state is JustificationDartLoaded) {
            setState(() {
              status = false;
              showTop(
                context: context,
                title: "Traitement réussi avec succès !",
                color: AppTheme.blueColor,
                icon: Icon(
                  FontAwesomeIcons.save,
                  color: Colors.white,
                ),
              );
              information.clear();
              init.add(Presencecharge(
                  refAgence: Mypreferences.CODE_AGENC_CONNECTED));
            });
          }
          if (state is JustificationDartFailed) {
            setState(() {
              status = false;
              showTop(
                context: context,
                title: "Erreur d'enrégistrement !.",
                color: AppTheme.redColor,
                icon: Icon(
                  FontAwesomeIcons.server,
                  color: Colors.white,
                ),
              );
            });
          }
        },
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: double.infinity,
            color: Colors.white,
            height: MediaQuery.of(context).size.height / 1.5,
            margin: MediaQuery.of(context).viewInsets,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                          color: AppTheme.redColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Informations supplémentaires sur le visiteur",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  CustomTextField(
                    controler: information,
                    hintText: "Autres information sur le visiteur",
                    title: "Information",
                    margeText: 9,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: FlatButton(
                      color: AppTheme.blueColor,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: !status
                              ? Text(
                                  "Enregistrer",
                                  style: TextStyle(
                                    color: Colors.white,
                                    // fontWeight: FontWeight.w400,
                                  ),
                                )
                              : SpinKitCircle(
                                  color: Colors.white,
                                  size: 35,
                                ),
                        ),
                      ),
                      onPressed: () {
                        setState(
                          () {
                            initBloc.add(JustificationDartSave(data: {
                              'motif': information.text,
                              'id': widget.id,
                              'code': widget.code,
                            }));
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
