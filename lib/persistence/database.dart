import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:v2/app/source.dart';
import 'package:v2/utils/constants.dart';

const DB = "dbsmico";

Database _database;
Future<Database> get database async {
  if (_database != null) {
    return _database;
  }
  return _database = await createDatabase();
}

Future<Database> createDatabase() async {
  try {
    String dbPath = await getDatabasesPath();
    return await openDatabase(join(dbPath, "$DB.db"), version: 1,
        onCreate: (Database database, int version) async {
      print("Database OK");
      await database.execute("""
        CREATE TABLE  presences (
          code  INTEGER PRIMARY KEY AUTOINCREMENT,
          codeAgent  varchar(255) DEFAULT NULL,
          codeAgence  varchar(255) DEFAULT  NULL,
          entree  VARCHAR(20)  DEFAULT '00:00:00',
          sortie  VARCHAR(20)  DEFAULT '00:00:00',
          dateAdd datetime DEFAULT CURRENT_TIMESTAMP,
          jour VARCHAR(255) NULL,
          synchro INT DEFAULT '0'
      )""");
      await database.execute("""
        CREATE TABLE agents(
          code  INTEGER PRIMARY KEY AUTOINCREMENT,
          id  varchar(255) UNIQUE,
          codeUser  int  NULL,
          codeFonction  int  NULL,
          codeAgence  int  NULL,
          nom  varchar(255) DEFAULT NULL,
          sexe  varchar(255) DEFAULT NULL,
          tel  varchar(255) DEFAULT NULL,
          email  varchar(255) DEFAULT NULL,
          adresse  varchar(255) DEFAULT NULL,
          type  varchar(255) DEFAULT NULL,
          dateAdd  datetime DEFAULT CURRENT_TIMESTAMP,
          codeEntrep  int  NULL,
          dateNaiss  date DEFAULT NULL,
          image  int DEFAULT '0',
          password  varchar(255) DEFAULT '0000',
          etat  int  NULL DEFAULT '0',
          synchro INT DEFAULT 0
        )""");

      await database.execute("""
        CREATE TABLE agences  (
          code  int UNIQUE,
          codeEntrep  VARCHAR(25)  NULL,
          id  varchar(255)  NULL,
          nom  varchar(255)  NULL,
          dateAdd  datetime DEFAULT CURRENT_TIMESTAMP,
          synchro INT DEFAULT 0
        )""");

      await database.execute("""
        CREATE TABLE  conge  (
          code  int UNIQUE,
          codeEntrep  int DEFAULT NULL,
          codeAgent  varchar(255) DEFAULT NULL,
          codeType  int DEFAULT NULL,
          debut  date DEFAULT NULL,
          fin  date DEFAULT NULL,
          description  varchar(255) DEFAULT NULL,
          etat  int DEFAULT '0',
          dateAdd  datetime DEFAULT CURRENT_TIMESTAMP,
          synchro INT DEFAULT 0
        )""");

      await database.execute("""
        CREATE TABLE  entreprise  (
          code  int UNIQUE,
          nom  varchar(255) DEFAULT NULL,
          tel  varchar(13) DEFAULT NULL,
          email  varchar(255) DEFAULT NULL,
          adresse  varchar(255) DEFAULT NULL,
          siteweb  varchar(255) DEFAULT NULL,
          logo  text,
          etat  int  NULL DEFAULT '0',
          dateAdd  datetime DEFAULT CURRENT_TIMESTAMP,
          codeValidation  int  NULL,
          url_articles  text,
          typeGestion  varchar(255) DEFAULT NULL,
          synchro INT DEFAULT 0
        )""");

      await database.execute("""
        CREATE TABLE  fonction(
          code  int UNIQUE,
          codeEntrep  int DEFAULT NULL,
          designation  varchar(255) DEFAULT NULL,
          dateAdd  datetime DEFAULT CURRENT_TIMESTAMP,
          etat  int  NULL DEFAULT '0',
          synchro INT DEFAULT 0
        )""");

      await database.execute("""
        CREATE TABLE  horaire(
          code  int UNIQUE,
          codeAgence  int DEFAULT NULL,
          codeEntrep  int DEFAULT NULL,
          jour  varchar(255) DEFAULT NULL,
          debut  time DEFAULT NULL,
          fin  time DEFAULT NULL,
          dateAdd  datetime DEFAULT CURRENT_TIMESTAMP,
          dateUpdate  datetime DEFAULT NULL,
          usersUpdate  int DEFAULT NULL,
          synchro INT DEFAULT 0
        )""");

      await database.execute("""
        CREATE TABLE  jour_non_ouvrable(
          code   int UNIQUE,
          codeEntrep  int DEFAULT NULL,
          date_  date DEFAULT NULL,
          designation  varchar(255) DEFAULT NULL,
          dateAdd  datetime DEFAULT CURRENT_TIMESTAMP,
          synchro INT DEFAULT 0
        )""");

      await database.execute("""
        CREATE TABLE  login_story(
          code   int UNIQUE,
          codeUser  int DEFAULT NULL,
          infos  varchar(255) DEFAULT NULL,
          etat  int DEFAULT '0',
          dateAdd  datetime DEFAULT CURRENT_TIMESTAMP,
          synchro INT DEFAULT 0
        )""");

      await database.execute("""
        CREATE TABLE  messages(
          code  int UNIQUE ,
          codeEntrep  int DEFAULT NULL,
          texte  text,
          dateAdd  datetime DEFAULT CURRENT_TIMESTAMP,
          etat  int DEFAULT '0',
          codeAgent  varchar(13)  NULL,
          synchro INT DEFAULT 0
        )""");

      await database.execute("""
        CREATE TABLE  pause(
          code  int UNIQUE,
          codeAgent  varchar(20) DEFAULT NULL,
          dateAdd  datetime DEFAULT CURRENT_TIMESTAMP,
          entree  time DEFAULT NULL,
          sortie  time DEFAULT '00:00:00',
          interTime  int DEFAULT '0',
          codeEntrep  int NULL,
          type  varchar(255) NULL,
          synchro INT DEFAULT 0
        )""");

      await database.execute("""
        CREATE TABLE type_agent(
          code  int UNIQUE,
          designation  varchar(255) DEFAULT NULL,
          dateAdd  datetime DEFAULT CURRENT_TIMESTAMP,
          codeEntrep  int DEFAULT NULL,
          synchro INT DEFAULT 0
        )""");

      await database.execute("""
        CREATE TABLE  type_conge  (
          code int UNIQUE,
          designation  varchar(255) DEFAULT NULL,
          dateAdd  datetime DEFAULT CURRENT_TIMESTAMP,
          codeEntrep  int  NULL,
          synchro INT DEFAULT 0
        )""");

      await database.execute("""
        CREATE TABLE  users  (
          code   varchar(155) UNIQUE,
          psedo  varchar(255)  NULL,
          pswd   varchar(255)  NULL,
          etat  varchar(25)  NULL,
          photo  varchar(255)  NULL,
          dateAdd  datetime DEFAULT CURRENT_TIMESTAMP,
          nom varchar(155)  ,
          tel  varchar(15)  NULL ,
          email  varchar(255)  NULL ,
          adresse  varchar(255) NULL,
          siteweb  varchar(255)  NULL ,
          codeValidation  varchar(255),
          logo  varchar(255) NULL,
          codeEntrep  varchar(200)  NULL ,
          fonction varchar(255) NULL,
          url_articles  varchar(600)  NULL,
          type  varchar(255)  NULL ,
          codeAgence  varchar(255)  NULL ,
          synchro INT DEFAULT 0
        )""");

      print("Tables OK");
    });
  } catch (e) {
    print(e.toString());
  }
  return null;
}

Future<List<dynamic>> findAll({String table, var column}) async {
  final db = await database;
  try {
    List<Map<String, dynamic>> resultat =
        await db.query(table, columns: column);
    if (resultat.length > 0) {
      return resultat;
    }
  } catch (_) {
    return [];
  }
  return null;
}

Future<List<String>> loadCombox({String sql}) async {
  final db = await database;
  try {
    List data = <String>[];
    List<Map<String, dynamic>> resultat = await db.rawQuery(sql);

    for (int index = 0; index < resultat.length; index++) {
      data.add(resultat[index]['element'].toString().toUpperCase());
    }
    print(data);
    return data;
  } catch (_) {
    return [];
    // print(_.toString());
  }
}

Future<List<String>> loadComb({String sql}) async {
  final db = await database;
  try {
    List data = <String>[];
    List<Map<String, dynamic>> resultat = await db.rawQuery(sql);

    for (int index = 0; index < resultat.length; index++) {
      data.add(
          "${resultat[index]['nom'].toString() + '-' + resultat[index]['code'].toString()}");
    }
    return data;
  } catch (_) {
    print(_.toString());
  }
}

Future<int> saveData({Object model, String table}) async {
  var db = await database;
  var resultat = await db.insert(table, model,
      conflictAlgorithm: ConflictAlgorithm.replace);
  return resultat;
}

Future<List<dynamic>> initLogin(var query) async {
  List list = <dynamic>[];
  try {
    final db = await database;
    List<Map<String, dynamic>> resultat = await db.rawQuery(query);
    resultat.forEach((element) {
      list.add(element);
    });
    return list;
  } catch (_) {
    print(_.toString());
  }
  return null;
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

Future<List<dynamic>> initCompteur(
    {var table, column, var condition, cible}) async {
  try {
    final db = await database;
    List<Map<String, dynamic>> resultat = await db
        .query(table, columns: column, where: condition, whereArgs: [cible]);

    return resultat;
  } catch (_) {
    print(_.toString());
  }
  return null;
}

Future<int> insert({Object object, var table}) async {
  try {
    var db = await database;
    return await db.insert(table, object,
        conflictAlgorithm: ConflictAlgorithm.replace);
  } catch (_) {
    print(_.toString());
  }
  return 0;
}

Future<int> update({var sql}) async {
  try {
    var db = await database;
    return await db.rawUpdate(sql);
  } catch (_) {
    print(_.toString());
  }
  return 0;
}

Future<List<dynamic>> initList({query}) async {
  try {
    final db = await database;
    List<Map<String, dynamic>> resultat = await db.rawQuery(query);
    return resultat;
  } catch (_) {
    print(_.toString());
  }
  return null;
}

Future<void> sendPause() async {
  try {
    bool connect = await connectionState().whenComplete(() => null);
    final db = await database;
    await db.rawQuery("SELECT  * FROM pause WHERE synchro=0").then((value) {
      print(value);
      if (connect) {
        for (int i = 0; i < value.length; i++) {
          var data = value[i];
          DataSource.getInstance
              .download(
                  REQUEST:
                      "INSERT INTO `pause`(`codeAgent`, `dateAdd`, `entree`, `sortie`, `interTime`, `codeEntrep`, `type`) VALUES (${data['codeAgent']},${data['dateAdd']},${data['entree']},${data['sortie']},${data['interTime']},${data['codeEntrep']},${data['type']}")
              .then((resultat) {
            if (resultat == 1) {
              db.rawUpdate("UPDATE presences SET synchro='1' WHERE code=?",
                  [data['code']]);
            }
          });
        }
      } else {
        print("Erreur de la connexion...");
      }
    });
  } catch (e) {
    print(e.toString());
  }
}

Future<void> sendPresence() async {
  try {
    bool connect = await connectionState().whenComplete(() => null);
    final db = await database;
    await db.rawQuery("SELECT  * FROM presences WHERE synchro=0").then((value) {
      print(value);
      if (connect) {
        for (int i = 0; i < value.length; i++) {
          var data = value[i];
          DataSource.getInstance
              .download(
                  REQUEST:
                      "INSERT INTO `presences`(`codeAgent`, `codeAgence`, `entree`, `sortie`, `personne`,`codeEntrep`, `retard`, `dateAdd`, ) VALUES (${data['codeAgent']},${data['codeAgence']},${data['entree']},${data['sortie']},${data['dateAdd']},${data['jour']}")
              .then((resultat) {
            if (resultat == 1) {
              db.rawUpdate("UPDATE presences SET synchro='1' WHERE code=?",
                  [data['code']]);
            }
          });
        }
      } else {
        print("Erreur de la connexion...");
      }
    });
  } catch (e) {
    print(e.toString());
  }
}
