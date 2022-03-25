class ModelAgent {
  String code;
  String id;
  String codeUser;
  String codeFonction;
  String codeAgence;
  String nom;
  String sexe;
  String tel;
  String email;
  String adresse;
  String type;
  String dateAdd;
  String codeEntrep;
  String dateNaiss;
  String image;
  String password;
  String etat;
  String synchro;

  ModelAgent(
      {this.code,
      this.id,
      this.codeUser,
      this.codeFonction,
      this.codeAgence,
      this.nom,
      this.sexe,
      this.tel,
      this.email,
      this.adresse,
      this.type,
      this.dateAdd,
      this.codeEntrep,
      this.dateNaiss,
      this.image,
      this.password,
      this.etat,
      this.synchro});

  ModelAgent.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    id = json['id'];
    codeUser = json['codeUser'];
    codeFonction = json['codeFonction'];
    codeAgence = json['codeAgence'];
    nom = json['nom'];
    sexe = json['sexe'];
    tel = json['tel'];
    email = json['email'];
    adresse = json['adresse'];
    type = json['type'];
    dateAdd = json['dateAdd'];
    codeEntrep = json['codeEntrep'];
    dateNaiss = json['dateNaiss'];
    image = json['image'];
    password = json['password'];
    etat = json['etat'];
    synchro = json['synchro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['id'] = this.id;
    data['codeUser'] = this.codeUser;
    data['codeFonction'] = this.codeFonction;
    data['codeAgence'] = this.codeAgence;
    data['nom'] = this.nom;
    data['sexe'] = this.sexe;
    data['tel'] = this.tel;
    data['email'] = this.email;
    data['adresse'] = this.adresse;
    data['type'] = this.type;
    data['dateAdd'] = this.dateAdd;
    data['codeEntrep'] = this.codeEntrep;
    data['dateNaiss'] = this.dateNaiss;
    data['image'] = this.image;
    data['password'] = this.password;
    data['etat'] = this.etat;
    data['synchro'] = this.synchro;
    return data;
  }
}
