class ModelAgence {
  String code;
  String codeEntrep;
  String id;
  String nom;
  String dateAdd;
  String synchro;

  ModelAgence(
      {this.code,
      this.codeEntrep,
      this.id,
      this.nom,
      this.dateAdd,
      this.synchro});

  ModelAgence.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    codeEntrep = json['codeEntrep'];
    id = json['id'];
    nom = json['nom'];
    dateAdd = json['dateAdd'];
    synchro = json['synchro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['codeEntrep'] = this.codeEntrep;
    data['id'] = this.id;
    data['nom'] = this.nom;
    data['dateAdd'] = this.dateAdd;
    data['synchro'] = this.synchro;
    return data;
  }
}
