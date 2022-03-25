import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SessionDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateBody();
  }
}

class _StateBody extends State<SessionDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: MediaQuery.of(context).size.height * .5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Voulez-vous enregistrer votre mot de passe \npour votre prochaine connexon?",
              style: TextStyle(
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
