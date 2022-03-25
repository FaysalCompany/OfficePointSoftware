import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:v2/utils/app_theme.dart';
import 'package:v2/utils/mypreferences.dart';
import 'package:v2/utils/widget.dart';
import 'package:v2/utils/constants.dart';

class ScreenEntreprise extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScreenEntreprise();
  }
}

class _ScreenEntreprise extends State<ScreenEntreprise> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: double.infinity,
          margin: MediaQuery.of(context).viewInsets,
          height: MediaQuery.of(context).size.height * .2,
          color: Colors.white,
          child: ListView(
            physics: ScrollPhysics(),
            children: [
              CustomTextField(
                hintText: " ",
                title: 'Succursale',
                // controler: designation,
                readOnly: true,
                child: cbList(
                    list: isList(value: Constantes.listSuccursalle),
                    title: "Succursale",
                    valeur: Constantes.succursalle,
                    onChanged: (val) {
                      setState(() {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Constantes.succursalle = val;
                      });
                    }),
                onPressed: () {
                  setState(() {});
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 80.0, right: 80, bottom: 10),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  color: AppTheme.blueColor,
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.save,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 3.0,
                        ),
                        Text(
                          "valider",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      if (Constantes.succursalle != null) {
                        init();
                      } else {
                        showTop(
                          context: context,
                          title: "Compléter les champs vides",
                          color: AppTheme.redColor,
                          icon: Icon(
                            Icons.warning,
                            color: Colors.white,
                          ),
                        );
                      }
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> init() async {
    bool bl = await Mypreferences.mypreferences()
        .setToken(key: 'key', numero: Constantes.succursalle.split('-').last);
    await Mypreferences().getToken('key');
    if (bl) {
      setState(() {
        setState(() {
          Constantes.succursalle = null;
          Navigator.of(context).pop();
        });
      });
    }
  }
}
