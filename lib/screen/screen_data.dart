import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:v2/app/source.dart';
import 'package:v2/bloc/presence_bloc.dart';
import 'package:v2/screen/dialogue_forget_card.dart';
import 'package:v2/screen/screen_justification.dart';
import 'package:v2/utils/app_theme.dart';
import 'package:v2/utils/constants.dart';
import 'package:v2/utils/mypreferences.dart';
import 'package:v2/utils/widget.dart';
import 'dialo_presecence.dart';
import 'viewImage.dart';

bool status = false;

class ScreenData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<ScreenData> {
  var initBloc;

  @override
  void initState() {
    super.initState();
    initBloc = BlocProvider.of<PresenceBloc>(context);
    init();
  }

  Future<void> init() async {
    await Mypreferences().getToken('key');
    initBloc.add(Presencecharge(refAgence: Mypreferences.CODE_AGENC_CONNECTED));
  }

  @override
  Widget build(BuildContext context) {
    return buildCard();
  }

  buildCard() {
    return Container(
      color: Colors.white,
      child: BlocListener<PresenceBloc, PresenceState>(
        listener: (context, state) {
          if (state is PresencePregress) {
            setState(() {
              status = true;
              FocusScope.of(context).requestFocus(FocusNode());
              Center(
                child: Load(),
              );
            });
          }
          if (state is PresenceLoading) {
            setState(() {
              Center(
                child: Load(),
              );
            });
          }
          if (state is PresenceIsEmpty) {
            setState(() {
              status = false;
              showTop(
                context: context,
                title: "Votre carte est invalide",
                color: AppTheme.redColor,
                icon: Icon(
                  Icons.warning,
                  color: Colors.white,
                ),
              );
            });
          }
          if (state is PresenceConnected) {
            setState(() {
              status = false;
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            BuildMessageConnected(
                              sizeImage: 150.0,
                              sizeText: 18.0,
                              onPressed: () {
                                setState(() {
                                  Navigator.of(context).pop();
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  });
            });
          }
          if (state is PresenceVisiteur) {
            setState(() {
              status = false;
              showDialog(
                  context: context,
                  builder: (context) {
                    return Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ScreenJustification(
                              id: state.idVisiteur,
                              code: state.code,
                            )
                          ],
                        ),
                      ),
                    );
                  });
            });
          }
          if (state is PresenceSucces) {
            setState(() {
              status = false;
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return Center(
                      child: SingleChildScrollView(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            DialoPresence(resultat: state.data[0])
                          ],
                        ),
                      ),
                    );
                  });
              showTop(
                context: context,
                title: "Presence confirmée avec succès",
                color: Colors.black,
                icon: Icon(
                  FontAwesomeIcons.qrcode,
                  color: Colors.white,
                ),
              );
              initBloc.add(Presencecharge(
                  refAgence: Mypreferences.CODE_AGENC_CONNECTED));
            });
          }
        },
        child: Stack(
          children: [
            BlocBuilder<PresenceBloc, PresenceState>(
              builder: (context, state) {
                if (state is PresenceInitiaList) {
                  return Center(child: Load());
                }
                if (state is PresenceConnectedList) {
                  return Center(
                    child: BuildMessageConnected(
                      sizeImage: 150.0,
                      sizeText: 18.0,
                      onPressed: () {
                        setState(() {
                          Navigator.of(context).pop();
                        });
                      },
                    ),
                  );
                }
                if (state is PresenceisEmptyList) {
                  return Center(
                    child: BuildMessage(
                      sizeImage: 150.0,
                      sizeText: 15.0,
                    ),
                  );
                }
                if (state is PresenceLoadingList && initBloc.replay.isEmpty) {
                  return Center(
                    child: Load(),
                  );
                }

                List<dynamic> data = initBloc.replay;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ViewImage(
                              data: data[index],
                            );
                          }));
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Card(
                          elevation: 0.0,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    child: CachedNetworkImage(
                                      useOldImageOnUrlChange: true,
                                      imageUrl:
                                          "${DataSource.imgUrl}${data[index]['image'] == '1' ? data[index]['codeAgent'] : 'default'}$extantion",
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        "assets/default.png",
                                      ),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          SpinKitCircle(
                                        duration: Duration(seconds: 3),
                                        color: AppTheme.redColor,
                                        size: 25,
                                      ),
                                      imageBuilder: (context, imageProvider) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
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
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data[index]['nom'].toUpperCase(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                data[index]['entree'],
                                                style: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontSize: 13,
                                                  // fontWeight: FontWeight.w100,
                                                ),
                                              ),
                                              SizedBox(width: 20),
                                              Text(
                                                data[index]['sortie'],
                                                style: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontSize: 13,
                                                  // fontWeight: FontWeight.w100,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppTheme.blueColor,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Icon(
                                      Icons.wifi_protected_setup,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              Divider(color: AppTheme.blueColor)
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            Positioned(
              top: 10,
              right: 40,
              child: InkWell(
                onTap: () {
                  setState(
                    () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        isDismissible: false,
                        context: context,
                        builder: (context) {
                          return SingleChildScrollView(
                            child: ForgetCard(),
                          );
                        },
                      );
                    },
                  );
                },
                child: Container(
                  height: 40,
                  width: 40,
                  child: Icon(
                    Icons.sim_card_download_sharp,
                    color: AppTheme.redColor,
                    size: 30,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 3, color: AppTheme.redColor),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
