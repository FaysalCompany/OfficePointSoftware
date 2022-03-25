class ModelPresenceLocal {
  String code;
  String codeAgent;
  String codeAgence;
  String entree;
  String sortie;
  String dateAdd;
  String jour;
  String synchro;

  ModelPresenceLocal(
      {this.code,
      this.codeAgent,
      this.entree,
      this.sortie,
      this.jour,
      this.synchro,
      this.codeAgence,
      this.dateAdd});

  ModelPresenceLocal.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    codeAgent = json['codeAgent'];
    entree = json['entree'];
    sortie = json['sortie'];
    jour = json['jour'];
    codeAgence = json['codeAgence'];
    dateAdd = json['dateAdd'];
    synchro = json['synchro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['codeAgent'] = this.codeAgent;
    data['entree'] = this.entree;
    data['sortie'] = this.sortie;
    data['jour'] = this.jour;
    data['dateAdd'] = this.dateAdd;
    data['codeAgence'] = this.codeAgence;
    data['synchro'] = this.synchro;
    return data;
  }
}
