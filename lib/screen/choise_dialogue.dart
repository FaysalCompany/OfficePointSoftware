import 'dart:io';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:v2/bloc/pause_bloc.dart';
import 'package:v2/utils/app_theme.dart';
import 'package:v2/utils/mypreferences.dart';
import 'package:v2/utils/scan_attributs.dart';

class ChoiseDialogue extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<ChoiseDialogue> {
  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);
  bool canVibrate = true;
  List<BarcodeFormat> selectedFormats = [..._possibleFormats];
  bool status = true;
  int selectIndex = 0;
  double _screenWidthAdjustment;
  var initData;
  var type = "Pause";
  @override
  void initState() {
    super.initState();
    initData = BlocProvider.of<PauseBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Material(
        child: Container(
          width: MediaQuery.of(context).size.width / 1.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: FlatButton(
                    height: 50,
                    color: AppTheme.blueColor,
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.pauseCircle, color: Colors.white),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Pause",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        type = "Pause";
                        initScane(scanner: scanCard(initValueScan));
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: FlatButton(
                    color: AppTheme.redColor,
                    height: 50,
                    child: Row(
                      children: [
                        Icon(
                          Icons.timer,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Heure supplém",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        type = "Sup";
                        initScane(scanner: scanCard(initValueScan));
                      });
                      // Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  initValueScan(value) {
    initData.add(
      PauseSend(data: {
        'scan': value,
        'refEntreprise': Mypreferences.CODE_ENTREPRISE,
        'type': type,
        'codeAgence': Mypreferences.CODE_AGENC_CONNECTED
      }),
    );
    Navigator.of(context).pop();
  }

// $scan=$data['scan'];
// $refEntreprise=$data['refEntreprise'];
// $type=$data['type'];
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
}
