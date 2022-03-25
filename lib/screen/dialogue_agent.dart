import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2/utils/app_theme.dart';
import 'package:v2/utils/constants.dart';
import 'package:v2/utils/widget.dart';

class DialogueAgent extends StatefulWidget {
  final TextEditingController dataSelect;
  const DialogueAgent({Key key, this.dataSelect}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _StateBody();
}

class _StateBody extends State<DialogueAgent> {
  List desplay = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Material(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * .7,
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              CustomTextField(
                controler: null,
                hintText: "Rechercher la personne a visiter",
                title: "Search",
                onChanged: (val) {
                  setState(() {
                    desplay.clear();
                    desplay.addAll(Constantes.listAgent);
                    desplay.retainWhere((element) {
                      return element
                          .toString()
                          .toLowerCase()
                          .contains(val.toString().toLowerCase());
                    });
                  });
                },
                onPressed: () {},
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: desplay.length > 0
                      ? ListView.builder(
                          itemCount: desplay.length,
                          itemBuilder: (context, index) {
                            var data = desplay[index];
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  widget.dataSelect.text = data;
                                  // Constantes.personne = data.toString();
                                  Navigator.pop(context);
                                });
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        child: Center(
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            color: AppTheme.blueColor,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "${data.toString().toUpperCase()}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: AppTheme.blueColor,
                                  ),
                                ],
                              ),
                            );
                          })
                      : Center(
                          child: BuildMessage(
                            sizeImage: 150.0,
                            sizeText: 15.0,
                          ),
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
