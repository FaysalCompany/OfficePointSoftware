import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:v2/bloc/login_bloc.dart';
import 'package:v2/utils/app_theme.dart';
import 'package:v2/utils/constants.dart';
import 'package:v2/utils/mypreferences.dart';
import 'package:v2/utils/start_activity.dart';
import 'package:v2/utils/widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

final controlUsername = new TextEditingController();
final controlpassword = new TextEditingController();

class _LoginPageState extends State<LoginPage> {
  // UserBloc _user;
  bool _isLoading = false;
  bool _statusConnected = false;
  bool _passShown;
  final formLoginKey = new GlobalKey<FormState>();
  var initBloc;
  @override
  void initState() {
    super.initState();
    _passShown = false;
    initBloc = BlocProvider.of<LoginBloc>(context);
    initConnected();
    // _user = new UserBloc();
  }

  Future<void> initConnected() async {
    await Mypreferences.mypreferences().getProfil().then((value) => {
          if (value)
            {
              setState(() {
                _statusConnected = true;
                initBloc.add(
                  LoginSing({
                    'username': Mypreferences.psedo.trim(),
                    'password': Mypreferences.pswd.trim(),
                  }),
                );
              })
            }
        });
  }

  Future<void> initSession({data, username, password}) async {
    await Mypreferences.mypreferences()
        .setProfil(
      data: data,
      username: username,
      password: password,
    )
        .then((value) {
      Navigator.pop(context);
      startActivityWithoutBackPop(context, '/presence');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
      inAsyncCall: _isLoading,
      progressIndicator: SpinKitSpinningLines(
        color: AppTheme.blueColor,
        // size: 25,
      ),
      child: Center(
        child: loginBody(),
      ),
    ));
  }

  loginBody() => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            loginHeader(),
            Form(
              key: formLoginKey,
              child: loginFields(),
            ),
          ],
        ),
      );

  loginHeader() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 148.0,
            width: 148.0,
            child: new CircleAvatar(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.green[600],
              radius: 100.0,
              // backgroundImage: AssetImage('assets/logo.png'),
              child: SvgPicture.asset('assets/welcom.svg'),
              // child: new Text(
              //   "",
              //   style: TextStyle(
              //     fontSize: 70.0,
              //     fontWeight: FontWeight.w100,
              //   ),
              // ),
            ),
            decoration: BoxDecoration(
                // border: Border.all(
                //   color: Colors.green[600],
                //   width: 2.0,
                // ),
                // shape: BoxShape.circle,
                //image: DecorationImage(image: this.logo)
                ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            "OFFICE POINT",
            style: TextStyle(
                fontWeight: FontWeight.w700, color: AppTheme.redColor),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "Sign in to continue",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      );
  buildRequest({nom, password, data}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => SimpleDialog(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        children: <Widget>[
          Container(
            width: 250,
            child: Column(
              children: <Widget>[
                Container(
                  child: SvgPicture.asset(
                    "assets/attebtion.svg",
                    width: 70,
                    height: 70,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 0,
                  ),
                  child: Text(
                    "Connexion",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Text(
                    "Voulez-vous enregistrer votre mot de passe pour votre prochaine connexion",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      color: AppTheme.redColor,
                      onPressed: () {
                        startActivityWithoutBackPop(context, '/presence');
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 80.0,
                        child: Text(
                          "Non",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    FlatButton(
                      color: AppTheme.blueColor,
                      onPressed: () {
                        setState(() {
                          initSession(
                              username: nom, password: password, data: data);
                        });

                        // widget.appBloc.add(LogoutEvent());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 80.0,
                        child: Text(
                          "Oui",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  loginFields() => BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginProgress) {
            setState(() {
              FocusScope.of(context).requestFocus(FocusNode());
              _isLoading = true;
            });
          }
          if (state is LoginConnected) {
            setState(() {
              _isLoading = false;
              showTop(
                context: context,
                title: "Veuillez vérifier votre connexion internet",
                color: AppTheme.redColor,
                icon: Icon(
                  FontAwesomeIcons.server,
                  color: Colors.white,
                ),
              );
            });
          }
          if (state is LoginFailed) {
            setState(() {
              showTop(
                context: context,
                title: "Authentification incorrecte",
                color: AppTheme.redColor,
                icon: Icon(
                  FontAwesomeIcons.cloudflare,
                  color: Colors.white,
                ),
              );
              _isLoading = false;
            });
          }
          if (state is LoginSucces) {
            setState(() {
              Constantes.listUserConnecter = state.resultat;
              print(state.resultat);
              _isLoading = false;
              if (_statusConnected) {
                startActivityWithoutBackPop(context, '/presence');
              } else {
                buildRequest(
                  nom: controlUsername.text,
                  password: controlpassword.text,
                  data: state.resultat,
                );
                controlUsername.clear();
                controlpassword.clear();
              }
            });
          }

          if (state is LoginSessesion) {
            setState(() {
              // initSession(state.resultat);
            });
          }
        },
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
                child: TextFormField(
                  controller: controlUsername,
                  maxLines: 1,
                  style: TextStyle(color: AppTheme.blueColor),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.mail_outline,
                        color: AppTheme.redColor,
                      ),
                      hintText: "Enter your username",
                      hintStyle: TextStyle(color: AppTheme.blueColor),
                      labelText: "Username",
                      labelStyle: TextStyle(color: AppTheme.blueColor)),
                  validator: (val) => val.length == 0
                      ? "Ce champs ne doit pas etre vide"
                      : null,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                child: TextFormField(
                  controller: controlpassword,
                  maxLines: 1,
                  obscureText: !_passShown,
                  style: TextStyle(color: AppTheme.blueColor),
                  decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.lock_outline, color: AppTheme.redColor),
                      suffixIcon: IconButton(
                          icon: Icon(_passShown
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            if (_passShown) {
                              setState(() {
                                _passShown = false;
                              });
                            } else {
                              setState(() {
                                _passShown = true;
                              });
                            }
                          }),
                      hintText: "Enter your password",
                      hintStyle: TextStyle(color: AppTheme.blueColor),
                      labelText: "Password",
                      labelStyle: TextStyle(color: AppTheme.blueColor)),
                  validator: (val) => val.length == 0
                      ? "Ce champs ne doit pas etre vide"
                      : null,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              /*  Container(
              child: BlocBuilder(
                bloc: _user,
                builder: (context, state){
                  if(state is BlocStateUninitialized){
                    return */
              Container(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                width: double.infinity,
                child: RaisedButton(
                    padding: EdgeInsets.all(12.0),
                    shape: StadiumBorder(),
                    child: Text(
                      "SIGN IN",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: AppTheme.blueColor,
                    onPressed: () {
                      print("object");
                      setState(() {
                        initBloc.add(
                          LoginSing({
                            'username': controlUsername.text,
                            'password': controlpassword.text,
                          }),
                        );
                      });
                      // Navigator.of(context).pushAndRemoveUntil(
                      //   MaterialPageRoute(builder: (builder)=>HomePage()),
                      //   (route) => false);

                      // _user.add(BlocEventLogin(username: controlUsername.text, pwd: controlpassword.text));

                      // Navigator.pushAndRemoveUntil(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (builder) =>
                      //             QuestionnairePage(user: user)),
                      //     (route) => false);
                    }),
              ),
              SizedBox(
                height: 5.0,
              ),
              FlatButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.only(left: 20.0),
                  alignment: Alignment.center,
                  child: Text(
                    "SIGN UP FOR AN ACCOUNT",
                    style: TextStyle(color: AppTheme.blueColor),
                  ),
                ),
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (builder) => SignupPage()));
                },
              )
            ],
          ),
        ),
      );
}
