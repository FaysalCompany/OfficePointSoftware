import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:v2/utils/app_theme.dart';
import 'package:v2/utils/mypreferences.dart';
import 'package:v2/utils/start_activity.dart';
import 'package:v2/utils/constants.dart';

class DrawerHome extends StatefulWidget {
  final appBloc;

  const DrawerHome({Key key, this.appBloc}) : super(key: key);
  @override
  _DrawerHomeState createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  @override
  void initState() {
    super.initState();
  }

  bool progress = true;
  bool prgrss = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildData(),
    );
  }

  buildData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 30.0),
        Row(
          children: <Widget>[
            buildProfile(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      Constantes.listUserConnecter[0]['nom']
                              .toString()
                              .toUpperCase() ??
                          "A/N",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      Constantes.listUserConnecter[0]['email'] ?? "A/N",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      Constantes.listUserConnecter[0]['fonction'] ?? "A/N",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.redColor,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Divider(),
        // CustomButtonDrawe(
        //   tilte: "Identifier",
        //   iconData: FontAwesomeIcons.userAlt,
        //   // etatClic: status1,
        //   onPressed: () {
        //     setState(() {});
        //   },
        // ),
        // CustomButtonDrawe(
        //   tilte: "Abonnement",
        //   iconData: FontAwesomeIcons.redRiver,
        //   etatClic: status2,
        //   onPressed: () {
        //     setState(() {
        //       status1 = false;
        //       status2 = true;
        //       status3 = false;
        //       status4 = false;
        //     });
        //   },
        // ),
        // CustomButtonDrawe(
        //   tilte: "Champ",
        //   iconData: FontAwesomeIcons.weightHanging,
        //   etatClic: status3,
        //   onPressed: () {
        //     setState(() {
        //       status1 = false;
        //       status2 = false;
        //       status3 = true;
        //       status4 = false;
        //     });
        //   },
        // ),
        // CustomButtonDrawe(
        //   tilte: "Champ",
        //   iconData: FontAwesomeIcons.solidMap,
        //   etatClic: status4,
        //   onPressed: () {
        //     setState(() {
        //       status1 = false;
        //       status2 = false;
        //       status3 = false;
        //       status4 = true;
        //     });
        //   },
        // ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            'assets/grand.svg',
            width: MediaQuery.of(context).size.width / 1.5,
          ),
        ),
        Spacer(),
        // Container(
        //   width: MediaQuery.of(context).size.width,
        //   padding: EdgeInsets.all(10.0),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(5.0),
        //     color: Colors.grey[200],
        //   ),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: <Widget>[
        //       // buildDetail(title: 'RCCM', value: '453-435-21'),
        //       // buildDetail(title: 'License', value: '37-09-20'),
        //       // buildDetail(title: 'Exp', value: '65-90-23'),
        //       Divider(),
        //       Text(
        //         "Version 0.0.1",
        //         textAlign: TextAlign.center,
        //         style: TextStyle(
        //           textStyle: TextStyle(
        //             fontSize: 14,
        //             color: Colors.black,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),

        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Version 0.0.1",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: buildLogOutButton(),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildLogOutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 50.0,
        width: 50.0,
        child: FlatButton(
          color: AppTheme.redColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Icon(Icons.exit_to_app, size: 20.0, color: Colors.white),
          onPressed: () {
            buildRequest();
            // widget.appBloc.add(LogoutRequestEvent());
          },
        ),
      ),
    );
  }

  buildRequest() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => SimpleDialog(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        children: <Widget>[
          Container(
            width: 250,
            child: Column(
              children: <Widget>[
                Container(
                  child: Icon(
                    Icons.info_outline,
                    size: 80,
                    color: AppTheme.blueColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 0,
                  ),
                  child: Text(
                    "Déconnexion",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Text(
                    "Voulez-vous enregistrer votre session pour votre prochaine connexon?",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      color: AppTheme.redColor,
                      onPressed: () {
                        Navigator.pop(context);
                        _singOut();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 80.0,
                        child: Text(
                          "Annuler",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    FlatButton(
                      color: AppTheme.blueColor,
                      onPressed: () {
                        Navigator.pop(context);
                        startActivityWithoutBackPop(context, '/session');
                        // widget.appBloc.add(LogoutEvent());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 80.0,
                        child: Text(
                          "Oui",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _singOut() async {
    await Mypreferences.mypreferences().singOut().then((value) {
      setState(() {
        startActivityWithoutBackPop(context, '/session');
      });
    });
  }

  Widget buildDetail({String title, String value}) {
    return Text.rich(
      TextSpan(
        text: "$title :\n",
        children: [
          TextSpan(
            text: '$value',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          )
        ],
        style: TextStyle(
          fontSize: 14,
          color: Colors.black54,
        ),
      ),
    );
  }

  buildProfile() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: 80,
        width: 80,
        // padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1, color: AppTheme.blueColor),
        ),
        child: CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage(
            'assets/default.png',
          ),
        ),
      ),
    );
  }
}
