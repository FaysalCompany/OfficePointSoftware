import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2/app/source.dart';
import 'package:v2/bloc/presence_bloc.dart';
import 'package:v2/screen/screen_data.dart';
import 'package:v2/utils/app_theme.dart';
import 'package:v2/utils/constants.dart';
import 'package:v2/utils/mypreferences.dart';
import 'package:v2/utils/widget.dart';

class ForgetCard extends StatefulWidget {
  // const ForgetCard({Key key, this.status}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _StateBody();
  }
}

class _StateBody extends State<ForgetCard> {
  var codeBar = TextEditingController();
  var initBloc;
  @override
  void initState() {
    super.initState();
    initBloc = BlocProvider.of<PresenceBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: double.infinity,
          margin: MediaQuery.of(context).viewInsets,
          height: MediaQuery.of(context).size.height * .25,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.sim_card_download_sharp,
                        size: 30, color: AppTheme.blueColor),
                    SizedBox(width: 4),
                    Text(
                      "SCAN MANUEL",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              CustomTextField(
                controler: codeBar,
                hintText: "Entrer le matricule",
                title: "ID-Matricule",
                onPressed: () {},
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
                              "Valider",
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
                    setState(() {
                      int x = dataScan(codeBar.text.trim()).hashCode.sign;
                      if (x == 1) {
                        Navigator.pop(context);
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  dataScan(value) {
    var data = {
      'barcode': value,
      'codeAgence': Mypreferences.CODE_AGENC_CONNECTED,
      'event': 'SCAN',
      'jour': initweekDay(DateTime.now()),
      'token': DataSource.getInstance.jwk_key,
    };
    initBloc.add(PresencesendData(data: data));
  }
}
