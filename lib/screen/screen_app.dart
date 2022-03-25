import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2/app/source.dart';
import 'package:v2/bloc/pause_bloc.dart';
import 'package:v2/utils/app_theme.dart';
import 'package:v2/utils/constants.dart';
import 'package:v2/utils/mypreferences.dart';
import 'package:v2/utils/widget.dart';

class ScreenApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<ScreenApp> {
  var initData;
  @override
  void initState() {
    super.initState();
    initData = BlocProvider.of<PauseBloc>(context);
    initData.add(PauseSend(data: {
      'scan': null,
      'refEntreprise': Mypreferences.CODE_ENTREPRISE,
      'type': "Pause",
      'codeAgence': Mypreferences.CODE_AGENC_CONNECTED,
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: BlocBuilder<PauseBloc, PauseState>(
          builder: (context, state) {
            if (state is PauseInitial) {
              return Center(
                child: Load(),
              );
            }
            if (state is PauseConnected) {
              return Center(
                  child: MessageConnected(
                sizeImage: 150.0,
                sizeText: 18.0,
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop();
                  });
                },
              ));
            }
            if (state is PauseIsEmpty) {
              return Center(
                child: BuildMessage(
                  sizeImage: 150.0,
                  sizeText: 15.0,
                ),
              );
            }
            if (state is PauseLoading && initData.data.length <= 0) {
              return Center(
                child: Load(),
              );
            } else {
              return ListView.builder(
                itemCount: initData.data.length,
                itemBuilder: (context, index) {
                  var data = initData.data[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Material(
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                CachedNetworkImage(
                                  useOldImageOnUrlChange: true,
                                  imageUrl:
                                      "${DataSource.imgUrl}${data['image'] == '1' ? data['code'] : 'default'}$extantion",
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    child: Image.asset(
                                      'assets/default.png',
                                      height: 100,
                                    ),
                                  ),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => SpinKitCircle(
                                    duration: Duration(seconds: 3),
                                    color: AppTheme.redColor,
                                    size: 25,
                                  ),
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        // shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                          colorFilter: ColorFilter.mode(
                                            Colors.white,
                                            BlendMode.colorBurn,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  height: 150,
                                  width: 150,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data['nom']}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${data['sexe'] == 'M' ? 'HOMME' : 'FEMMIN'}",
                                      style: TextStyle(
                                        fontSize: 12, color: AppTheme.redColor,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${data['tel']}",
                                      style: TextStyle(
                                        fontSize: 12, color: AppTheme.redColor,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          data['sortie'] == '00:00:00'
                                              ? Icons.pause_sharp
                                              : Icons.play_arrow,
                                          color: AppTheme.redColor,
                                          size: 20,
                                        ),
                                        Text(
                                          data['sortie'] == '00:00:00'
                                              ? "${data['type'] == 'Sup' ? 'Heures supplémentaires'.toUpperCase() : "Pause".toString().toUpperCase()}"
                                              : "DISPONIBLE",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: AppTheme.redColor,
                                              fontWeight: FontWeight.bold
                                              // fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "${data['entree'].toString().toUpperCase()}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: AppTheme.blueColor,

                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "${data['sortie'].toString().toUpperCase()}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: AppTheme.blueColor,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ));
  }

  String initS(valeur) {
    return valeur == 'Sup' ? "Heures supplémentaires" : "Pause";
  }
}

class UserCustom extends StatelessWidget {
  final Color color;
  final title;
  final IconData icon;
  final data;

  const UserCustom({Key key, this.color, this.title, this.icon, this.data})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        child: Row(
          children: [
            Icon(
              icon,
              size: 30,
              color: color,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${title}",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${data}",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
