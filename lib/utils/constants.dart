import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'app_theme.dart';

class Constantes {
  static String succursalle;
  static List listSuccursalle = <String>[];
  static String function;
  static List listfunction = <String>[];
  static String type;
  static List listType = <String>[];
  static List listAgent = <String>[];
  static List listVisiteur = <String>[];
  static List listUserConnecter = <dynamic>[];
  static String sexe;
  static String personne;
  static String fullname;
}

String _currentEngine;
var extantion = ".png";

Future<bool> connectionState() async {
  try {
    if (await isConnected()) {
      Future.delayed(Duration(seconds: 1));
      final resultat =
          await InternetAddress.lookup("officepoint.databankrdc.com");
      if (resultat.isNotEmpty && resultat[0].rawAddress.isNotEmpty) {
        print("api access");
        return true;
      }
    } else {
      print("Veuillez vérifier votre connexion internet");
      return false;
    }
  } on SocketException catch (_) {
    print("Veuillez vérifier votre connexion internet");
  }
  return false;
}

Future<bool> isConnected() async {
  try {
    bool connected = await DataConnectionChecker().hasConnection.then((value) {
      return value;
    }).catchError((onError) => false);
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      if (connected) {
        print("internet access");
        return true;
      } else {
        print("Veuillez vérifier votre connexion internet");
        return false;
      }
    } else {
      print(
          "Vous n'êtes pas connecté à internet \nReésayer votre demande ultérieurement");
      return false;
    }
  } catch (e) {
    print("Veuillez vérifier votre connexion internet");
    return false;
  }
}

String initweekDay(DateTime dateTime) {
  switch (dateTime.weekday) {
    case 1:
      return 'Lundi';
    case 2:
      return 'Mardi';
    case 3:
      return 'Mercredi';
    case 4:
      return 'Jeudi';
    case 5:
      return 'Vendredi';
    case 6:
      return 'Samedi';
    default:
      return 'Dimanche';
  }
}

class CustomButtonDrawe extends StatelessWidget {
  final onPressed;
  final tilte;
  final IconData iconData;
  final etatClic;

  const CustomButtonDrawe({
    Key key,
    this.onPressed,
    this.tilte,
    this.etatClic = false,
    this.iconData,
  }) : super(key: key);
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: SizedBox(
        height: 45.0,
        width: MediaQuery.of(context).size.width,
        child: FlatButton(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Row(
            children: <Widget>[
              Icon(
                iconData,
                size: 18.0,
                color: AppTheme.blueColor,
              ),
              SizedBox(width: 8.0),
              Text(
                tilte,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  color: AppTheme.blueColor,
                ),
              ),
            ],
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

Widget cbList({
  List<DropdownMenuItem<String>> list,
  title,
  String valeur,
  Function onChanged,
}) =>
    DropdownButtonFormField(
      isExpanded: true,
      items: list,
      value: valeur,
      onChanged: onChanged,
      hint: Text(
        "Sélectionnez ${title}",
        style: TextStyle(
          fontSize: 12,
        ),
      ),
      decoration: InputDecoration(
        //labelText: "Technologies",
        border: InputBorder.none,
        hintStyle: TextStyle(
            fontSize: 13, color: Colors.black, fontWeight: FontWeight.w500),
        contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      validator: (val) => val == null ? "Ce champs est obligatoire" : null,
      onSaved: (val) => valeur = val,
    );

List<DropdownMenuItem<String>> isList({List<String> value}) {
  return value
      .map(
        (val) => DropdownMenuItem(
          value: val,
          child: val == null || val.isEmpty
              ? Text("")
              : Row(
                  children: [
                    Container(
                      height: 16,
                      width: 16,
                      child: Center(
                        child: Text(
                          val.substring(0, 1).toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: AppTheme.blueColor,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    SizedBox(width: 3),
                    Text(
                      val,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
        ),
      )
      .toList();
}

// selectEngine() => DropdownButtonFormField<String>(
//       decoration: Style.inputDecorationSpinner(
//           label: translate(context: context, key: 'currency'), hint: 'CDF'),
//       isExpanded: false,
//       items: [
//         tileCurrency("CDF", Icons.monetization_on),
//         tileCurrency("USD", MdiIcons.contactlessPayment),
//       ],
//       onChanged: (value) {
//         setState(() {
//           _currentEngine = value;
//           getCurrency(device: value);
//         });
//       },
//       value: _currentEngine,
//     );

// tileCurrency(String title, IconData icon) {
//   return DropdownMenuItem(
//     value: title,
//     child: Container(
//       child: Row(
//         children: <Widget>[
//           Container(
//             width: dimens_30,
//             height: dimens_30,
//             decoration:
//                 BoxDecoration(shape: BoxShape.circle, color: color_primary),
//             child: Center(
//               child: Icon(
//                 icon,
//                 color: color_white,
//                 size: dimens_24,
//               ),
//             ),
//           ),
//           SizedBox(
//             width: dimens_16,
//           ),
//           Text(title, style: Style.styleTitle(accent: color_black)),
//         ],
//       ),
//     ),
//   );
// }
class CardOper extends StatelessWidget {
  final type;
  final montant;
  final date;
  final motif;
  final user;
  final devise;
  final VoidCallback onPressed;

  const CardOper(
      {Key key,
      this.type,
      this.montant,
      this.date,
      this.motif,
      this.user,
      this.devise,
      this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5.0),
      child: Material(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 100,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "$type",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 13.0),
                            child: Text(
                              "${date}",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 13.0),
                            child: Text(
                              "${motif}",
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: AppTheme.blueColor,
                                  size: 14,
                                ),
                                Expanded(
                                  child: Text(
                                    "${user}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.blueColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Positioned(
              //   right: MediaQuery.of(context).size.width / 5,
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Container(
              //       width: MediaQuery.of(context).size.width / 2,
              //       height: 50,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10),
              //         color: AppTheme.blueColor,
              //       ),
              //       child: Padding(
              //         padding: const EdgeInsets.only(left: 8.0),
              //         child: Column(
              //           crossAxisAlignment:
              //               CrossAxisAlignment.center,
              //           children: [
              //             Text(
              //               "Entree",
              //               style: TextStyle(
              //                 color: Colors.white60,
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: 16,
              //               ),
              //             ),
              //             Text(
              //               "\$ 200.000",
              //               style: TextStyle(
              //                 color: Colors.white,
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: 20,
              //               ),
              //             )
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
