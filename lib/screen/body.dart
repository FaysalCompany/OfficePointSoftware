import 'dart:io';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:v2/app/source.dart';
import 'package:v2/bloc/presence_bloc.dart';
import 'package:v2/model/modelPresence.dart';
import 'package:v2/persistence/view_download.dart';
import 'package:v2/screen/screen_app.dart';
import 'package:v2/screen/screen_data.dart';
import 'package:v2/screen/screen_identification.dart';
import 'package:v2/utils/app_theme.dart';
import 'package:v2/utils/constants.dart';
import 'package:v2/utils/mypreferences.dart';
import 'package:v2/utils/scan_attributs.dart';
import 'choise_dialogue.dart';
import 'drawe_home.dart';
import 'ecreen_entreprise.dart';

class Body extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const Body({Key key, this.scaffoldKey}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  var initBloc;
  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);
  bool canVibrate = true;
  List<BarcodeFormat> selectedFormats = [..._possibleFormats];
  bool status = false;
  int selectIndex = 0;
  List heroTypeList = <ModelPresence>[];
  double screenWidthAdjustment;
  @override
  void initState() {
    super.initState();
    Mypreferences.CODE_AGENC_CONNECTED =
        Constantes.listUserConnecter[0]['codeAgence'] ?? "0";
    Mypreferences.CODE_ENTREPRISE =
        Constantes.listUserConnecter[0]['codeEntrep'] ?? "0";
    init();
    initBloc = BlocProvider.of<PresenceBloc>(context);
    initBloc.add(Presencechargecbx(id: Mypreferences.CODE_ENTREPRISE));
  }

  int currentTab = 0;
  final List<Widget> screens = [ScreenData(), ScreenIdentifed(), ScreenApp()];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = ScreenData();
  void initSelect(index) {
    setState(() {
      selectIndex = index;
    });
  }

  Future<void> init() async {
    await Mypreferences().getToken('key');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      drawer: Container(
        width: MediaQuery.of(context).size.width * 5 / 6.5,
        child: Drawer(
          child: DrawerHome(),
          elevation: 3,
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData.fallback(),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          children: [
            Text(
              "OFFICE",
              style: TextStyle(
                  color: AppTheme.blueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
            Text(
              " POINT",
              style: TextStyle(
                  color: AppTheme.blueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ],
        ),
        actions: [
          BlocBuilder<PresenceBloc, PresenceState>(
            builder: (context, state) {
              if (state is PresenceInitial) {
                return Center(
                  child: SpinKitFadingFour(
                    color: AppTheme.redColor,
                    size: 20,
                    // size: 25,
                  ),
                );
              }
              if (state is PresenceConnected) {
                return Center(
                  child: Icon(
                    Icons.error,
                    color: AppTheme.redColor,

                    // size: 25,
                  ),
                );
              }
              if (state is PresenceLoading && initBloc.desplay.isEmpty) {
                return Center(
                  child: Icon(
                    Icons.error,
                    color: AppTheme.redColor,
                    // size: 25,
                  ),
                );
              }
              Constantes.listAgent = initBloc.desplayA;
              Constantes.listSuccursalle = initBloc.desplay;
              Constantes.listType = initBloc.desplayT;
              Constantes.listfunction = initBloc.desplayF;
              status = true;
              return InkWell(
                onTap: () {
                  setState(() {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      isDismissible: true,
                      isScrollControlled: false,
                      context: context,
                      builder: (context) {
                        return Center(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ViewDialog(),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                    // initData();
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(25),
                    // border: Border.all(color: AppTheme.blueColor, width: 0),
                  ),
                  child: Center(
                      child: Icon(
                    Icons.signal_cellular_connected_no_internet_4_bar_outlined,
                    color: AppTheme.blueColor,
                  )),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: AppTheme.blueColor,
              // size: 35,
            ),
            onPressed: () {
              setState(() {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ScreenEntreprise(),
                          ],
                        ),
                      ),
                    );
                  },
                );

                //       // print(initweekDay(DateTime.now()));
                //       // initScane(scanner: scanCard());
              });
            },
          ),
        ],
      ),
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Container(
          height: 40,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.person_pin,
                  color: currentTab == 1 ? AppTheme.blueColor : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    currentScreen = screens.elementAt(1);
                    currentTab = 1;
                  });
                },
              ),
              SizedBox(width: MediaQuery.of(context).size.width * .2),
              IconButton(
                icon: Icon(
                  Icons.move_to_inbox,
                  color: currentTab == 2 ? AppTheme.blueColor : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    currentScreen = screens.elementAt(2);
                    currentTab = 2;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            currentTab == 0 ? AppTheme.blueColor : AppTheme.redColor,
        child: Icon(
          Icons.qr_code,
          color: AppTheme.whiteColor,
        ),
        onPressed: () {
          setState(() {
            if (currentTab == 2) {
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [ChoiseDialogue()],
                        ),
                      ),
                    );
                  });
            } else {
              initScane(scanner: scanCard(dataScan));
              if (currentTab != 0) {
                currentTab = 0;
                currentScreen = screens.elementAt(0);
              }
            }
          });
        },
      ),
    );
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
