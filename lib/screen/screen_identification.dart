import 'dart:convert';
import 'dart:io';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:v2/bloc/identify_bloc.dart';
import 'package:v2/bloc/visiteur_bloc.dart';
import 'package:v2/search/screen_search.dart';
import 'package:v2/utils/app_theme.dart';
import 'package:v2/utils/constants.dart';
import 'package:v2/utils/mypreferences.dart';
import 'package:v2/utils/scan_attributs.dart';
import 'package:v2/utils/widget.dart';
import 'package:image_picker/image_picker.dart';

import 'dialogue_agent.dart';

class ScreenIdentifed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<ScreenIdentifed> {
  final dateofBirth = TextEditingController();
  final scan = TextEditingController();
  final fullname = TextEditingController();
  final phoneNumber = TextEditingController();
  final adress = TextEditingController();
  final email = TextEditingController();
  final description = TextEditingController();
  final fonction = TextEditingController();
  final personne = TextEditingController();
  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);
  bool canVibrate = true;
  List<BarcodeFormat> selectedFormats = [..._possibleFormats];
  var init;
  var visiteur;
  bool clic = true;
  @override
  void initState() {
    super.initState();
    initID();
    init = BlocProvider.of<IdentifyBloc>(context);
    visiteur = BlocProvider.of<VisiteurBloc>(context);
    init.add(IdentifyFetch());
  }

  var genre = "M";
  bool status = false;
  File _image;
  String path;
  final picker = ImagePicker();
  Future getImage({bool bol = false}) async {
    final pickedFile = await picker.getImage(
      source: bol ? ImageSource.camera : ImageSource.gallery,
    );
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        // contImage.text = _image.path.split('/').last;
        path = base64Encode(_image.readAsBytesSync());
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> initID() async {
    await Mypreferences().getToken('key');
  }

  DateTime _dateTime;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocListener<IdentifyBloc, IdentifyState>(
        listener: (context, state) {
          if (state is IdentifyPregress) {
            setState(
              () {
                status = true;
                FocusScope.of(context).requestFocus(FocusNode());
              },
            );
          }
          if (state is IdentifyConnected) {
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
          if (state is IdentifyFailed) {
            setState(() {
              status = false;
            });
          }
          if (state is IdentifySucces) {
            setState(() {
              status = false;
              showTop(
                context: context,
                title: state.message,
                color: AppTheme.blueColor,
                icon: Icon(
                  FontAwesomeIcons.affiliatetheme,
                  color: AppTheme.redColor,
                ),
              );

              scan.clear();
              fullname.clear();
              phoneNumber.clear();
              adress.clear();
              email.clear();
              dateofBirth.clear();
              Constantes.sexe = null;
              Constantes.function = null;
              Constantes.type = null;
              _image = null;
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        FocusScope.of(context).requestFocus(FocusNode());
                        clic = true;
                        scan.clear();
                        fullname.clear();
                        phoneNumber.clear();
                        adress.clear();
                        description.clear();
                        Constantes.sexe = null;
                        status = false;
                        fonction.clear();
                      });
                    },
                    child: Container(
                      width: 100,
                      height: clic ? 35 : 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        color: clic ? AppTheme.blueColor : Colors.white,
                        border: Border.all(
                          color: clic ? AppTheme.blueColor : AppTheme.redColor,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_add_outlined,
                              color: clic ? Colors.white : AppTheme.redColor,
                            ),
                            Text(
                              'Agents',
                              style: TextStyle(
                                color: clic ? Colors.white : AppTheme.redColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        clic = false;
                        scan.clear();
                        fullname.clear();
                        phoneNumber.clear();
                        adress.clear();
                        email.clear();
                        dateofBirth.clear();
                        Constantes.sexe = null;
                        Constantes.function = null;
                        Constantes.type = null;
                        _image = null;
                        status = false;
                        FocusScope.of(context).requestFocus(FocusNode());
                      });
                    },
                    child: Container(
                      width: 100,
                      height: clic ? 25 : 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          color: clic ? Colors.white : AppTheme.blueColor,
                          border: Border.all(
                            color:
                                clic ? AppTheme.redColor : AppTheme.blueColor,
                            width: 1,
                          )),
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_add,
                              color: clic ? AppTheme.redColor : Colors.white,
                            ),
                            Text(
                              'Visiteurs',
                              style: TextStyle(
                                color: clic ? AppTheme.redColor : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              clic ? builCardAgent() : builCardVisiteur(),
            ],
          ),
        ),
      ),
    );
  }

  builCardVisiteur() {
    return Container(
      child: BlocListener<VisiteurBloc, VisiteurState>(
        listener: (context, state) {
          if (state is VisiteurProgress) {
            setState(() {
              status = true;
              FocusScope.of(context).requestFocus(FocusNode());
            });
          }
          if (state is VisiteurConnected) {
            setState(() {
              status = false;
              showTop(
                  context: context,
                  title: "Veuillez vérifier votre connexion internet",
                  color: AppTheme.redColor,
                  icon: Icon(FontAwesomeIcons.server, color: Colors.white));
            });
          }
          if (state is VisiteurLoading) {
            setState(() {
              status = false;
            });
          }
          if (state is VisiteurSucces) {
            setState(() {
              status = false;
              showTop(
                  context: context,
                  title: state.data,
                  color: Colors.green.shade800,
                  icon: Icon(FontAwesomeIcons.affiliatetheme,
                      color: AppTheme.redColor));
              scan.clear();
              fullname.clear();
              phoneNumber.clear();
              adress.clear();
              description.clear();
              Constantes.sexe = null;
              Constantes.personne = null;
              fonction.clear();
              personne.clear();
            });
          }
          if (state is VisiteurError) {
            setState(() {
              status = false;
              showTop(
                  context: context,
                  title: state.msg,
                  color: AppTheme.redColor,
                  icon: Icon(FontAwesomeIcons.server, color: Colors.white));
            });
          }
        },
        child: Expanded(
          child: ListView(
            children: [
              // CustomTextField(
              //   hintText: "Entrer le mot",
              //   title: "Rechercher...",
              //   readOnly: true,
              //   onPressed: () {
              //     try {
              //       showSearch(context: context, delegate: SearchOperation())
              //           .then((value) {
              //         setState(
              //           () {
              //             scan.text = value.substring(1, value.indexOf("%^"));
              //             fullname.text = value.substring(
              //                 value.indexOf("%^") + 3, value.indexOf("**"));
              //             dateofBirth.text = value.substring(
              //                 value.indexOf("++") + 3, value.indexOf("##"));
              //             phoneNumber.text = value.substring(
              //                 value.indexOf("##") + 3, value.indexOf("&&"));
              //             adress.text = value.substring(
              //                 value.indexOf("&&") + 3, value.indexOf("^^"));
              //             email.text = value.substring(
              //                 value.indexOf("^^") + 3, value.indexOf("%%"));
              //           },
              //         );
              //       });
              //     } catch (e) {
              //       print(e.toString());
              //     }
              //   },
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     color: Colors.white,
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Container(
              //           decoration: BoxDecoration(
              //             color: Colors.white,
              //             shape: BoxShape.circle,
              //             border: Border.all(
              //               color: AppTheme.blueColor,
              //               width: 1,
              //             ),
              //           ),
              //           child: GestureDetector(
              //             onTap: () {
              //               setState(() {
              //                 _showChoiceDialog(context);
              //               });
              //             },
              //             child: CircleAvatar(
              //               backgroundColor: Colors.white,
              //               radius: 50,
              //               backgroundImage: _image != null
              //                   ? FileImage(
              //                       _image,
              //                       scale: 1.0,
              //                     )
              //                   : null,
              //               child: _image == null
              //                   ? Icon(
              //                       Icons.camera_outlined,
              //                       size: 50,
              //                     )
              //                   : null,
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controler: scan,
                      hintText: "Scan la carte",
                      title: "ID carte",
                      readOnly: true,
                      onPressed: () {
                        setState(() {
                          initScane(scanner: scanCard(inforCarte));
                        });
                      },
                    ),
                  ),
                  Container(
                    width: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppTheme.redColor.withOpacity(.4),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          try {
                            showSearch(
                                    context: context,
                                    delegate: SearchOperation())
                                .then((value) {
                              setState(
                                () {
                                  scan.text =
                                      value.substring(1, value.indexOf("%^"));
                                  fullname.text = value.substring(
                                      value.indexOf("%^") + 3,
                                      value.indexOf("**"));

                                  phoneNumber.text = value.substring(
                                      value.indexOf("##") + 3,
                                      value.indexOf("&&"));
                                  adress.text = value.substring(
                                      value.indexOf("&&") + 3,
                                      value.indexOf("^^"));
                                },
                              );
                            });
                          } catch (e) {
                            print(e.toString());
                          }
                        });
                      },
                    ),
                  )
                ],
              ),
              CustomTextField(
                controler: fullname,
                hintText: "Entrer le nom complet",
                title: "Nom",
                onPressed: () {},
              ),
              CustomTextField(
                // controler: txtnom,
                hintText: "",
                title: "Genre",
                child: cbList(
                    list: isList(value: ['M', 'F']),
                    title: "le genre",
                    valeur: Constantes.sexe,
                    onChanged: (val) {
                      setState(() {
                        Constantes.sexe = val;
                        FocusScope.of(context).requestFocus(FocusNode());
                      });
                    }),
              ),
              CustomTextField(
                controler: phoneNumber,
                hintText: "Entrer numéro de téléphone",
                textInputType: TextInputType.phone,
                title: "Numéro",
              ),
              CustomTextField(
                controler: fonction,
                hintText: "Entrer la fonction",
                title: "Fonction",
              ),
              CustomTextField(
                controler: adress,
                hintText: "Entrer l'adresse",
                title: "Adresse",
              ),

              CustomTextField(
                controler: personne,
                hintText: "Entrer la personne visitée",
                textInputType: TextInputType.text,
                title: "Personne",
                readOnly: true,
                onPressed: () {
                  setState(() {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      isDismissible: false,
                      context: context,
                      builder: (context) {
                        return SingleChildScrollView(
                          child: DialogueAgent(
                            dataSelect: personne,
                          ),
                        );
                      },
                    );
                  });
                },
                // child: cbList(
                //   list: isList(value: Constantes.listAgent),
                //   title: "la personne",
                //   valeur: Constantes.personne,
                //   onChanged: (val) {
                //     setState(() {
                //       Constantes.personne = val;
                //       FocusScope.of(context).requestFocus(FocusNode());
                //     });
                //   },
                // ),

                // margeText: 3,
              ),
              CustomTextField(
                  controler: description,
                  hintText: "Entrer la description",
                  title: "Description",
                  margeText: 5),
              // CustomTextField(
              //   // controler: txtnom,
              //   hintText: "Entrer le Type",
              //   title: "Type",
              //   child: cbList(
              //     list: isList(value: Constantes.listType),
              //     title: "le type",
              //     valeur: Constantes.type,
              //     onChanged: (val) {
              //       setState(() {
              //         Constantes.type = val;
              //         FocusScope.of(context).requestFocus(FocusNode());
              //       });
              //     },
              //   ),
              // ),
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
                    setState(() {
                      initID().whenComplete(() => null);
                      final data = {
                        'id': scan.text,
                        'name': fullname.text,
                        'tel': phoneNumber.text,
                        'adresse': adress.text,
                        'description': description.text,
                        'sexe': Constantes.sexe,
                        'function': fonction.text,
                        'codeAgence': Mypreferences.CODE_AGENC_CONNECTED,
                        'codeEntrep': Mypreferences.CODE_ENTREPRISE,
                        'codeUser':
                            Constantes.listUserConnecter[0]['code'] ?? "1",
                        'jour': initweekDay(DateTime.now()),
                        'personne': personne.text
                      };
                      visiteur.add(VisiteurSave(data));
                    });
                  },
                ),
              ),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }

  builCardAgent() {
    return Expanded(
      child: ListView(
        children: [
          // CustomTextField(
          //   hintText: "Entrer le mot",
          //   title: "Rechercher...",
          //   readOnly: true,
          //   onPressed: () {
          //     try {
          //       showSearch(context: context, delegate: SearchOperation())
          //           .then((value) {
          //         setState(
          //           () {
          //             scan.text = value.substring(1, value.indexOf("%^"));
          //             fullname.text = value.substring(
          //                 value.indexOf("%^") + 3, value.indexOf("**"));
          //             dateofBirth.text = value.substring(
          //                 value.indexOf("++") + 3, value.indexOf("##"));
          //             phoneNumber.text = value.substring(
          //                 value.indexOf("##") + 3, value.indexOf("&&"));
          //             adress.text = value.substring(
          //                 value.indexOf("&&") + 3, value.indexOf("^^"));
          //             email.text = value.substring(
          //                 value.indexOf("^^") + 3, value.indexOf("%%"));
          //           },
          //         );
          //       });
          //     } catch (e) {
          //       print(e.toString());
          //     }
          //   },
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.blueColor,
                        width: 1,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _showChoiceDialog(context);
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50,
                        backgroundImage: _image != null
                            ? FileImage(
                                _image,
                                scale: 1.0,
                              )
                            : null,
                        child: _image == null
                            ? Icon(
                                Icons.camera_outlined,
                                size: 50,
                              )
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomTextField(
            controler: scan,
            hintText: "Scan la carte",
            title: "ID carte",
            readOnly: true,
            onPressed: () {
              setState(() {
                initScane(scanner: scanCard(inforCarte));
              });
            },
          ),
          CustomTextField(
            controler: fullname,
            hintText: "Entrer le nom complet",
            title: "Nom",
            onPressed: () {},
          ),
          CustomTextField(
            // controler: txtnom,
            hintText: "Entrer le nom complet",
            title: "Genre",
            child: cbList(
                list: isList(value: ['M', 'F']),
                title: "le genre",
                valeur: Constantes.sexe,
                onChanged: (val) {
                  setState(() {
                    Constantes.sexe = val;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                }),
          ),
          CustomTextField(
            controler: dateofBirth,
            hintText: "Entrer la date de naissance",
            title: "Date naissance",
            readOnly: true,
            onPressed: () async {
              _dateTime = await showDatePicker(
                  context: context,
                  initialDate: DateTime(DateTime.now().year),
                  firstDate: DateTime(1880),
                  lastDate: DateTime(DateTime.now().year + 1));
              if (_dateTime != null) {
                setState(() {
                  dateofBirth.text = _dateTime.toString().substring(0, 10);
                });
              }
            },
          ),
          CustomTextField(
            controler: phoneNumber,
            hintText: "Entrer numéro de téléphone",
            textInputType: TextInputType.phone,
            title: "Numéro",
          ),
          CustomTextField(
            controler: adress,
            hintText: "Entrer l'adresse",
            title: "Adresse",
          ),
          CustomTextField(
            controler: email,
            hintText: "Entrer l'adresse email",
            textInputType: TextInputType.emailAddress,
            title: "Email",
          ),
          CustomTextField(
            // controler: txtnom,
            hintText: "Entrer le Type",
            title: "Fonction",
            child: cbList(
              list: isList(value: Constantes.listfunction),
              title: "la fonction",
              valeur: Constantes.function,
              onChanged: (val) {
                setState(() {
                  Constantes.function = val;
                  FocusScope.of(context).requestFocus(FocusNode());
                });
              },
            ),
          ),
          CustomTextField(
            // controler: txtnom,
            hintText: "Entrer le Type",
            title: "Type",
            child: cbList(
              list: isList(value: Constantes.listType),
              title: "le type",
              valeur: Constantes.type,
              onChanged: (val) {
                setState(() {
                  Constantes.type = val;
                  FocusScope.of(context).requestFocus(FocusNode());
                });
              },
            ),
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
                    initID().whenComplete(() => null);
                    var bytes;
                    if (_image != null) {
                      bytes = _image.readAsBytesSync();
                    }
                    final data = {
                      'image_name':
                          _image != null ? base64Encode(bytes) : '000',
                      'image_id': "photos",
                      'id': scan.text,
                      'nom': fullname.text,
                      'tel': phoneNumber.text,
                      'adresse': adress.text,
                      'email': email.text,
                      'dateNaiss': dateofBirth.text,
                      'sexe': Constantes.sexe,
                      'function': Constantes.function,
                      'type': Constantes.type,
                      'codeAgence': Mypreferences.CODE_AGENC_CONNECTED,
                      'codeEntrep': Mypreferences.CODE_ENTREPRISE,
                      'codeUser':
                          Constantes.listUserConnecter[0]['code'] ?? "1",
                      "photoname": _image != null
                          ? _image.absolute.path.split('/').last
                          : "000"
                    };
                    init.add(IdentifySend(data));
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Fais un choix",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.white,
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: FlatButton(
                      color: AppTheme.blueColor,
                      child: Text(
                        "Gallerie",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        getImage(bol: false);
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  FlatButton(
                    color: AppTheme.redColor,
                    child: Text(
                      "Caméra",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      getImage(bol: true);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  initScane({void scanner}) {
    var contentList = <Widget>[
      if (qrResultat != null)
        Card(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text("Result Type"),
                subtitle: Text(qrResultat.type?.toString() ?? ""),
              ),
              ListTile(
                title: Text("Raw Content"),
                subtitle: Text(qrResultat.rawContent ?? ""),
              ),
              ListTile(
                title: Text("Format"),
                subtitle: Text(qrResultat.format?.toString() ?? ""),
              ),
              ListTile(
                title: Text("Format note"),
                subtitle: Text(qrResultat.formatNote ?? ""),
              ),
            ],
          ),
        ),
      ListTile(
        title: Text("Camera selection"),
        dense: true,
        enabled: false,
      ),
      RadioListTile(
        onChanged: (v) => setState(() => selectedCamera = -1),
        value: -1,
        title: Text("Default camera"),
        groupValue: selectedCamera,
      ),
    ];
    for (var i = 0; i < numberOfCameras; i++) {
      contentList.add(RadioListTile(
        onChanged: (v) => setState(() => selectedCamera = i),
        value: i,
        title: Text("Camera ${i + 1}"),
        groupValue: selectedCamera,
      ));
    }

    contentList.addAll([
      ListTile(
        title: Text("Button Texts"),
        dense: true,
        enabled: false,
      ),
      ListTile(
        title: TextField(
          decoration: InputDecoration(
            hasFloatingPlaceholder: true,
            labelText: "Flash On",
          ),
          controller: flashOnController,
        ),
      ),
      ListTile(
        title: TextField(
          decoration: InputDecoration(
            hasFloatingPlaceholder: true,
            labelText: "Flash Off",
          ),
          controller: flashOffController,
        ),
      ),
      ListTile(
        title: TextField(
          decoration: InputDecoration(
            hasFloatingPlaceholder: true,
            labelText: "Cancel",
          ),
          controller: cancelController,
        ),
      ),
    ]);

    if (Platform.isAndroid) {
      contentList.addAll([
        ListTile(
          title: Text("Android specific options"),
          dense: true,
          enabled: false,
        ),
        ListTile(
          title:
              Text("Aspect tolerance (${aspectTolerance.toStringAsFixed(2)})"),
          subtitle: Slider(
            min: -1.0,
            max: 1.0,
            value: aspectTolerance,
            onChanged: (value) {
              setState(() {
                aspectTolerance = value;
              });
            },
          ),
        ),
        CheckboxListTile(
          title: Text("Use autofocus"),
          value: useAutoFocus,
          onChanged: (checked) {
            setState(() {
              useAutoFocus = checked;
            });
          },
        )
      ]);
    }

    contentList.addAll([
      ListTile(
        title: Text("Other options"),
        dense: true,
        enabled: false,
      ),
      CheckboxListTile(
        title: Text("Start with flash"),
        value: autoEnableFlash,
        onChanged: (checked) {
          setState(() {
            autoEnableFlash = checked;
          });
        },
      )
    ]);

    contentList.addAll([
      ListTile(
        title: Text("Barcode formats"),
        dense: true,
        enabled: false,
      ),
      ListTile(
        trailing: Checkbox(
          tristate: true,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: selectedFormats.length == _possibleFormats.length
              ? true
              : selectedFormats.length == 0
                  ? false
                  : null,
          onChanged: (checked) {
            setState(() {
              selectedFormats = [
                if (checked ?? false) ..._possibleFormats,
              ];
            });
          },
        ),
        dense: true,
        enabled: false,
        title: Text("Detect barcode formats"),
        subtitle: Text(
          'If all are unselected, all possible platform formats will be used',
        ),
      ),
    ]);

    contentList.addAll(
      _possibleFormats.map(
        (format) => CheckboxListTile(
          value: selectedFormats.contains(format),
          onChanged: (i) {
            setState(() => selectedFormats.contains(format)
                ? selectedFormats.remove(format)
                : selectedFormats.add(format));
          },
          title: Text(format.toString()),
        ),
      ),
    );
  }

  Future scanCard(Function function) async {
    try {
      var options = ScanOptions(
        strings: {
          "cancel": cancelController.text,
          "flash_on": flashOnController.text,
          "flash_off": flashOffController.text,
        },
        restrictFormat: selectedFormats,
        useCamera: possitionCamera,
        autoEnableFlash: autoEnableFlash,
        android: AndroidOptions(
          aspectTolerance: aspectTolerance,
          useAutoFocus: useAutoFocus,
        ),
      );
      var resultat = await BarcodeScanner.scan(options: options);
      setState(() async {
        qrResultat = resultat;
        if (qrResultat.rawContent.length > 0) {
          setState(() {
            function(qrResultat.rawContent);
          });

          // idCarte.text = qrResultat.rawContent;

        }
      });
    } on PlatformException catch (_) {
      if (_.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          print("Camera permissin was denied");
        });
      } else {
        setState(() {
          print("Unknown Error $_");
        });
      }
    } on FormatException {
      setState(() {
        print("You pressed the back button before scanning anithing");
      });
    } catch (_) {
      setState(() {
        print("Unknown Error $_");
      });
    }
  }

  inforCarte(value) {
    scan.text = value;
  }

  // Future<void> initList() async {
  //   Constantes.listVisiteur =
  //       await DataSource.getInstance.initFetchVisiteur().then((value) {
  //     setState(() {
  //       print(value);
  //     });
  //   });
  // }
}
