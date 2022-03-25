import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:v2/screen/screen_span.dart';
import 'package:v2/utils/app_theme.dart';
import 'package:v2/utils/scan_attributs.dart';

class ScreenConnect extends StatefulWidget {
  static String rootName = '/screenConnect';
  @override
  _ScreenConnect createState() => _ScreenConnect();
}

class _ScreenConnect extends State<ScreenConnect> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Material(
                    elevation: 0,
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 50,
                      height: MediaQuery.of(context).size.height / 2.5,
                      child: Center(
                        child: Column(
                          children: [
                            AvatarGlow(
                              endRadius: 60,
                              glowColor: AppTheme.redColor,
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                      color: AppTheme.redColor, width: 1),
                                ),
                                child: Icon(
                                  Icons.cloud_off,
                                  size: 30,
                                  color: AppTheme.redColor,
                                ),
                              ),
                            ),
                            Text(
                              "Echec de la connexion",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              "Impossible de charger les donnees",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              child: Text(""),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 50.0,
                                right: 50.0,
                                bottom: 10,
                              ),
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                color: AppTheme.blueColor,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.refresh,
                                        color: AppTheme.whiteColor,
                                      ),
                                      SizedBox(
                                        width: 3.0,
                                      ),
                                      Text(
                                        "Réessayer",
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w300,
                                          color: AppTheme.whiteColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => ScreenSpan(),
                                      ),
                                    );
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 50.0,
                                right: 50.0,
                                bottom: 10,
                              ),
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                color: AppTheme.redColor,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.offline_bolt_outlined,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 3.0,
                                      ),
                                      Text(
                                        "Hors Ligne",
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w300,
                                            color: AppTheme.whiteColor),
                                      ),
                                    ],
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    isLocal = true;
                                    Navigator.pushReplacementNamed(
                                        context, '/myLogin');
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
