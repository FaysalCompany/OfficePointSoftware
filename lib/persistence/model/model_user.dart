class ModelUser {
  String code;
  String psedo;
  String etat;
  String photo;
  String dateAdd;
  String nom;
  String tel;
  String email;
  String adresse;
  String siteweb;
  String codeValidation;
  String logo;
  String codeEntrep;
  String fonction;
  String urlArticles;
  String type;
  String codeAgence;
  String pswd;
  String synchro;

  ModelUser(
      {this.code,
      this.psedo,
      this.etat,
      this.photo,
      this.dateAdd,
      this.nom,
      this.tel,
      this.email,
      this.adresse,
      this.siteweb,
      this.codeValidation,
      this.logo,
      this.codeEntrep,
      this.fonction,
      this.urlArticles,
      this.type,
      this.codeAgence,
      this.pswd,
      this.synchro});

  ModelUser.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    psedo = json['psedo'];
    pswd = json['pswd'];
    etat = json['etat'];
    photo = json['photo'];
    dateAdd = json['dateAdd'];
    nom = json['nom'];
    tel = json['tel'];
    email = json['email'];
    adresse = json['adresse'];
    siteweb = json['siteweb'];
    codeValidation = json['codeValidation'];
    logo = json['logo'];
    codeEntrep = json['codeEntrep'];
    fonction = json['fonction'];
    urlArticles = json['url_articles'];
    type = json['type'];
    codeAgence = json['codeAgence'];
    synchro = json['synchro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['psedo'] = this.psedo;
    data['pswd'] = this.pswd;
    data['etat'] = this.etat;
    data['photo'] = this.photo;
    data['dateAdd'] = this.dateAdd;
    data['nom'] = this.nom;
    data['tel'] = this.tel;
    data['email'] = this.email;
    data['adresse'] = this.adresse;
    data['siteweb'] = this.siteweb;
    data['codeValidation'] = this.codeValidation;
    data['logo'] = this.logo;
    data['codeEntrep'] = this.codeEntrep;
    data['fonction'] = this.fonction;
    data['url_articles'] = this.urlArticles;
    data['type'] = this.type;
    data['codeAgence'] = this.codeAgence;
    data['synchro'] = this.synchro;
    return data;
  }
}
