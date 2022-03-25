import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'app_theme.dart';

class Load extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.0,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Center(
          child: SpinKitSpinningLines(
            color: AppTheme.redColor,
            size: 30,
          ),
        ),
      ),
    );
  }
}

Widget showTop({BuildContext context, Icon icon, title, Color color}) =>
    Flushbar(
      icon: icon,
      shouldIconPulse: false,
      duration: Duration(seconds: 2),
      // message: title,
      messageText: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
      // borderColor: Colors.white,
      // borderRadius: 20,
      // borderWidth: 20,
      flushbarStyle: FlushbarStyle.GROUNDED,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
      backgroundColor: color,
      flushbarPosition: FlushbarPosition.BOTTOM,
      animationDuration: Duration(seconds: 1),
    )..show(context);

class BuildMessageSucces extends StatelessWidget {
  final sizeText;
  final sizeImage;
  final Function onPressed;

  const BuildMessageSucces(
      {Key key, this.sizeText, this.sizeImage, this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: SvgPicture.asset(
                "assets/undraw_Maintenance_re_59vn.svg",
                height: sizeImage,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Confirmer votre présence",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: sizeText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Confirmer votre présence",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      // fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80.0, right: 80, bottom: 10),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0),
                ),
                color: AppTheme.redColor,
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.qr_code_scanner,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Text(
                        "Clic ici pour scan ",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: onPressed,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BuildMessagePrincipale extends StatelessWidget {
  final sizeText;
  final sizeImage;
  final Function onPressed;

  const BuildMessagePrincipale(
      {Key key, this.sizeText, this.sizeImage, this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/logo smico.png',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80.0, right: 80, bottom: 10),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0)),
                color: AppTheme.blueColor,
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.qr_code_scanner,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Text(
                        "Clic ici pour scan votre carte ",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: onPressed,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BuildMessageConnected extends StatelessWidget {
  final sizeText;
  final sizeImage;
  final Function onPressed;

  const BuildMessageConnected(
      {Key key, this.sizeText, this.sizeImage, this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              )),
          height: MediaQuery.of(context).size.height / 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: SvgPicture.asset(
                  "assets/intern.svg",
                  height: sizeImage,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Connectez-vous à Internet",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: sizeText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Vous n'êtes pas connecté. Vérifiez votre connexion.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        // fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageConnected extends StatelessWidget {
  final sizeText;
  final sizeImage;
  final Function onPressed;
  const MessageConnected(
      {Key key, this.sizeText, this.sizeImage, this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: SvgPicture.asset(
                "assets/internet.svg",
                height: sizeImage,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Connectez-vous à Internet",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: sizeText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class BuildMessage extends StatelessWidget {
  final sizeText;
  final sizeImage;

  const BuildMessage({Key key, this.sizeText, this.sizeImage})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: SvgPicture.asset(
                "assets/isEmpty.svg",
                height: sizeImage,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                "Aucun résultat trouvé",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: sizeText,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final hintText;
  final VoidCallback onPressed;
  final controler;
  final margeText;
  final textInputType;
  final readOnly;
  final title;
  final focusrequest;
  final isobscure;
  final child;
  final onChanged;

  const CustomTextField({
    Key key,
    this.hintText,
    this.onPressed,
    this.controler,
    this.margeText,
    this.textInputType,
    this.readOnly = false,
    this.title,
    this.focusrequest,
    this.isobscure = false,
    this.child,
    this.onChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: Colors.white,
          border: Border.all(
            color: Colors.grey[100],
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.black),
              ),
              child == null
                  ? TextFormField(
                      obscureText: isobscure,
                      focusNode: focusrequest,
                      readOnly: readOnly,
                      keyboardType: textInputType,
                      maxLines: !isobscure ? margeText : 1,
                      controller: controler,
                      onChanged: onChanged,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hintText,
                      ),
                      onTap: onPressed,
                    )
                  : child,
            ],
          ),
        ),
      ),
    );
  }
}
