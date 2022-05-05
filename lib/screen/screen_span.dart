import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:v2/app/fade_animation.dart';
import 'package:v2/utils/app_theme.dart';
import 'package:v2/utils/constants.dart';
import 'package:v2/utils/start_activity.dart';
import 'package:v2/utils/widget.dart';

class ScreenSpan extends StatefulWidget {
  @override
  _ScreenSpan createState() => _ScreenSpan();
}

class _ScreenSpan extends State<ScreenSpan> {
  void initState() {
    super.initState();
    init();
  }

  bool connect;
  Future<void> init() async {
    await connectionState().then((value) => connect = value);
    if (connect) {
      isLogin();
    } else {
      Timer(Duration(seconds: 4), () {
        startActivityWithoutBackPop(context, '/screenConnect');
      });
    }
  }

  Future<void> isLogin() async {
    Timer(
      Duration(seconds: 4),
      () {
        startActivityWithoutBackPop(context, '/myLogin');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // maintainBottomViewPadding: true,
      child: Scaffold(
        extendBody: true,
        body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                FadeAnimation(1.3, getIcon()),
                FadeAnimation(1.6, ismamu()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getIcon() {
    return Container(
      // height: 160.0,
      // width: 160.0,
      child: Image.asset(
        'assets/office.jpg',
        width: 150,
      ),
      decoration: BoxDecoration(
          // border: Border.all(
          //   color: Colors.green[600],
          //   width: 2.0,
          // ),
          // shape: BoxShape.circle,
          //image: DecorationImage(image: this.logo)
          ),
    );
  }

  ismamu() {
    return FadeAnimation(
      2,
      Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Load(),
            SizedBox(width: 2.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Powered by Faysal',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: AppTheme.blueColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Company',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: AppTheme.blueColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
