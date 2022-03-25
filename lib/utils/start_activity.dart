import 'package:flutter/material.dart';

Future startActivity(BuildContext context, String activity) async =>
    await Navigator.of(context).pushNamed(activity);

Future startActivityWithoutBack(BuildContext context, String activity) async =>
    await Navigator.of(context).pushReplacementNamed(activity);

Future startActivityWithoutBackPop(
        BuildContext context, String activity) async =>
    await Navigator.of(context)
        .pushNamedAndRemoveUntil(activity, (Route<dynamic> route) => false);

Future onBackPress(BuildContext context) async => Navigator.of(context).pop();
