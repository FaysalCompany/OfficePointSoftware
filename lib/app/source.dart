import 'dart:convert';
import 'package:http/http.dart' as http;

class DataSource {
  static var imgUrl =
      "https://officepoint.databankrdc.com/file/fichiers/photos/";
  var url = "https://officepoint.databankrdc.com/file/api";
  var jwk_key = "7283DJ32O0IKMXA999323NN323238383MS10202_1";
  var urllocal = "https://officepoint.databankrdc.com/fichiers/".trim();

  static DataSource _instance;
  static DataSource get getInstance {
    return _instance == null ? _instance = DataSource() : _instance;
  }

  Future<List<String>> chargeCombox({var event}) async {
    List<String> list = [];
    try {
      final reponse = await http.post("${url}", body: {
        'event': "LOAD_AGENCE",
        'codeEntrep': event,
        'token': jwk_key
      });
      if (reponse.statusCode == 200) {
        var resultat = await jsonDecode(reponse.body);
        var data = resultat[0]['data'];
        for (int i = 0; i < data.length; i++) {
          list.add("${data[i]['nom'] + '-' + (data[i]['code'])}");
        }
        return list;
      }
    } catch (_) {
      print(_.toString());
    }
    return null;
  }

  Future<List<String>> chargeComboxType({var event}) async {
    List<String> list = [];
    try {
      final reponse = await http.post("${urllocal}fetchData.php",
          body: {'event': "LOAD_TYPE", 'refAgence': event});
      if (reponse.statusCode == 200) {
        var resultat = await jsonDecode(reponse.body);
        var data = resultat;
        for (int i = 0; i < data.length; i++) {
          list.add("${data[i]['designation']}");
        }
        return list;
      }
    } catch (_) {
      print(_.toString());
    }
    return null;
  }

  Future<List<String>> chargeComboxAgent({var event}) async {
    List<String> list = [];
    try {
      final reponse = await http.post("${urllocal}fetchData.php",
          body: {'event': "LOAD_AGENT", 'refAgence': event});
      if (reponse.statusCode == 200) {
        var resultat = await jsonDecode(reponse.body);
        var data = resultat;
        for (int i = 0; i < data.length; i++) {
          list.add("${data[i]['nom']}");
        }
        return list;
      }
    } catch (_) {
      print(_.toString());
    }
    return null;
  }

  Future<List<String>> chargeComboxFonction({var event}) async {
    List<String> list = [];
    try {
      final reponse = await http.post("${urllocal}fetchData.php",
          body: {'event': "LOAD_FUNCTION", 'refAgence': event});
      if (reponse.statusCode == 200) {
        var resultat = await jsonDecode(reponse.body);
        var data = resultat;
        for (int i = 0; i < data.length; i++) {
          list.add("${data[i]['designation']}");
        }
        return list;
      }
    } catch (_) {
      print(_.toString());
    }
    return null;
  }

  Future<String> identifiedSave({var data}) async {
    print(data);
    try {
      final reponse =
          await http.post("${urllocal}addPersonne.php", body: jsonEncode(data));
      var resulta = await jsonDecode(reponse.body);
      print(resulta["status"]);
      return resulta["status"];
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<String> identifiedVisiteur({var data}) async {
    try {
      print(data);
      final reponse = await http.post("${urllocal}addVisiteurs.php",
          body: jsonEncode(data));
      var resulta = await jsonDecode(reponse.body);
      return resulta["status"];
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<String> justificaSave({var data}) async {
    print(data);
    try {
      final reponse = await http.post("${urllocal}informationvisiteur.php",
          body: jsonEncode(data));
      var resulta = await jsonDecode(reponse.body);
      return resulta["status"];
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<List<dynamic>> initLogin({var data}) async {
    try {
      print("============LOGIN===========${data}");
      final reponse =
          await http.post("${urllocal}login.php", body: jsonEncode(data));
      var resulta = await jsonDecode(reponse.body);
      return resulta;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<List<dynamic>> initFetchVisiteur() async {
    try {
      List lis = <dynamic>[];
      final reponse = await http.post("${urllocal}fetchPersonne.php");
      var resulta = await jsonDecode(reponse.body);
      for (int i = 0; i < resulta.length; i++) {
        lis.add(resulta[i]);
      }
      return lis;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<List<dynamic>> identifySnan({var data}) async {
    try {
      final reponse = await http.post("${url}", body: data);
      print("------------------(DATA)----------------> $data");
      var resulta = await jsonDecode(reponse.body);
      return resulta;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<List<dynamic>> fetchPresence({var data}) async {
    try {
      List list = <dynamic>[];
      final reponse = await http
          .post("${urllocal}fetchPresence.php", body: {'refEntreprise': data});
      var resulta = await jsonDecode(reponse.body);
      for (int i = 0; i < resulta.length; i++) {
        list.add(resulta[i]);
      }
      return list;
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  Future<List<dynamic>> sendPause({var data}) async {
    List list = <dynamic>[];
    try {
      final reponse = await http.post("${urllocal}addMouvement.php",
          body: jsonEncode(data));
      var resulta = await jsonDecode(reponse.body);
      var rst = resulta['status'];
      for (int i = 0; i < rst.length; i++) {
        list.add(rst[i]);
      }
      return list;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<List<dynamic>> findAll({var REQUEST}) async {
    try {
      final reponse = await http.post("${urllocal}synchro.php",
          body: {'action': 'FIND_SYNC', 'REQUEST': REQUEST});
      if (reponse.statusCode == 200) {
        var resultat = await jsonDecode(reponse.body);
        return resultat;
      }
    } catch (_) {
      print(_.toString());
    }
    return null;
  }

  Future<int> download({var REQUEST}) async {
    try {
      final reponse = await http.post("${urllocal}synchro.php",
          body: {'action': 'DOWNLOAD', 'REQUEST': REQUEST});
      if (reponse.statusCode == 200) {
        var resultat = await jsonDecode(reponse.body);
        return resultat['status'];
      }
    } catch (_) {
      print(_.toString());
    }
    return null;
  }
}


// SELECT `code`, `designation`, `dateAdd`, `codeEntrep` FROM `type_agent` WHERE 1