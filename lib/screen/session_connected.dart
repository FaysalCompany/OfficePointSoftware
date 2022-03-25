import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2/utils/app_theme.dart';

import 'screen_login.dart';

// import 'package:gst_stock/ui_view/myspan.dart';

class SessionConnected extends StatefulWidget {
  static String rootName = '/session';
  @override
  _StateBody createState() => _StateBody();
}

class _StateBody extends State<SessionConnected> {
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
                      // height: MediaQuery.of(context).size.height / 2.5,
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                // border: Border.all(color: AppTheme.redColor, width: 1),
                              ),
                              child: SvgPicture.asset("assets/welcom.svg"),
                            ),
                            // Text(
                            //   "Echec de la connexion",
                            //   style: TextStyle(
                            //     fontSize: 13,
                            //     fontWeight: FontWeight.w300,
                            //   ),
                            // ),
                            // Text(
                            //   "Impossible de charger les donnees",
                            //   style: TextStyle(
                            //     fontSize: 16,
                            //     fontWeight: FontWeight.w400,
                            //   ),
                            // ),
                            SizedBox(
                              child: Text(""),
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white,
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) => LoginPage(),
                                          ),
                                        );
                                      });
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width -
                                          50,
                                      child: Center(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.connect_without_contact,
                                            color: AppTheme.blueColor,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "APPUYER ICI POUR CONTINUER",
                                            style: TextStyle(
                                                color: AppTheme.redColor),
                                          ),
                                        ],
                                      )),
                                      // width:
                                      // MediaQuery.of(context).size.width,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(
                                          color: AppTheme.blueColor,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
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
