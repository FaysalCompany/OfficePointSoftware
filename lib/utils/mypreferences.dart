import 'package:shared_preferences/shared_preferences.dart';

const String CODE_AGENCE = null;

class Mypreferences {
  static Mypreferences _mypreferences;
  static String numero;
  static String CODE_ENTREPRISE = "1";
  static String CODE_AGENC_CONNECTED;
  // static String CODE_ENTREPRISE=
  static String code;
  static String psedo;
  static String pswd;
  static String etat;
  static String dateAdd;
  static String nom;
  static String tel;
  static String email;
  static String adresse;
  static String siteweb;
  static String codeValidation;
  static String logo;
  static String codeEntrep;
  static String fonction;
  static String urlArticles;
  static String type;
  static String codeAgence;

  static Mypreferences mypreferences() {
    if (_mypreferences == null) {
      _mypreferences = Mypreferences();
    }
    return _mypreferences;
  }

  Future<bool> setToken({String key, String numero}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, numero);
  }

  Future<bool> setProfil({var data, username, password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var resultat = data[0];
    prefs.setString('psedo', username ?? null);
    prefs.setString('pswd', password ?? null);
    prefs.setString('codeEntrep', resultat['codeEntrep'] ?? null);
    return prefs.setString('codeAgence', resultat['codeAgence'] ?? null);
  }

  Future<bool> getProfil() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    psedo = pref.getString("psedo");
    pswd = pref.getString("pswd");
    codeAgence = pref.getString("codeAgence");
    codeEntrep = pref.getString('codeEntrep');

    return codeAgence != null ? true : false;
  }

  Future<bool> singOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.clear();
  }

  Future<bool> getToken(String _key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    numero = preferences.getString(_key) ?? "1";
    if (preferences.getString(_key) != null) {
      return true;
    }
    return false;
  }
}
