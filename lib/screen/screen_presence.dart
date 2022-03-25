import 'package:flutter/material.dart';
import 'package:v2/screen/body.dart';

// ignore: must_be_immutable
class ScreenPresence extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Body(
      scaffoldKey: scaffoldKey,
    );
  }
}
