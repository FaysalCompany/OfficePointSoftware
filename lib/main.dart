import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v2/bloc/identify_bloc.dart';
import 'package:v2/bloc/justification_dart_bloc.dart';
import 'package:v2/bloc/login_bloc.dart';
import 'package:v2/bloc/pause_bloc.dart';
import 'package:v2/bloc/visiteur_bloc.dart';
import 'package:v2/persistence/database.dart';
import 'package:v2/screen/screen_connect.dart';
import 'package:v2/screen/screen_presence.dart';
import 'package:v2/screen/screen_span.dart';
import 'bloc/presence_bloc.dart';
import 'persistence/model/my_http.dart';
import 'screen/screen_login.dart';
import 'screen/session_connected.dart';
import 'screen/viewImage.dart';
import 'utils/app_theme.dart';

void main() {
  if (!kIsWeb) _setTargetPlatformForDesktop();
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

void _setTargetPlatformForDesktop() {
  TargetPlatform targetPlatform;
  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.android;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }

  // static void setLocale(BuildContext context, Locale locale) {
  //   _MyApp state = context.findAncestorStateOfType<_MyApp>();
  //   state.setLocale(locale);
  // }
}

class _MyApp extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppTheme.redColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness:
            Platform.isAndroid ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: Colors.grey[150],
        systemNavigationBarDividerColor: Colors.grey,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    database;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PresenceBloc()),
        BlocProvider(create: (context) => IdentifyBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => JustificationDartBloc()),
        BlocProvider(create: (context) => VisiteurBloc()),
        BlocProvider(create: (context) => PauseBloc())
      ],
      child: MaterialApp(
        title: 'OFFICE-POINT',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
          dividerTheme: DividerThemeData(space: 0),
          fontFamily: '${AppTheme.primaryFont}',
        ),
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/presence': (_) => ScreenPresence(),
          '/viewimage': (_) => ViewImage(),
          '/myLogin': (_) => LoginPage(),
          '/screenConnect': (_) => ScreenConnect(),
          '/session': (_) => SessionConnected()
        },
        home: ScreenSpan(),
      ),
    );
  }
  // Locale _locale;

  // void setLocale(Locale locale) => setState(() => _locale = locale);

}
