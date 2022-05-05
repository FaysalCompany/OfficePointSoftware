import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:v2/app/source.dart';
import 'package:v2/utils/app_theme.dart';
import 'package:v2/utils/constants.dart';

class DialoPresence extends StatefulWidget {
  final resultat;

  const DialoPresence({Key key, this.resultat}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<DialoPresence> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Material(
        child: Container(
          width: double.infinity,
          margin: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: AppTheme.redColor),
                child: Center(
                  child: Text(
                    "${widget.resultat['nom'].toString().toUpperCase()}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2,
                child: CachedNetworkImage(
                  useOldImageOnUrlChange: true,
                  imageUrl:
                      "${DataSource.imgUrl}${widget.resultat['image'] == '1' ? widget.resultat['codeAgent'] : 'default'}$extantion",
                  errorWidget: (context, url, error) => Image.asset(
                    "assets/default.png",
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
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: AppTheme.blueColor),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 1),
                      Text(
                        "${widget.resultat['entree'] != "00:00:00" ? "ENTREE" : "00:00:00"}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "${widget.resultat['sortie'] != "00:00:00" ? "SORTIE" : "00:00:00"}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 1),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
