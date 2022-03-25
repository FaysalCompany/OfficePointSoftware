class ModelPause {
  String code;
  String codeAgent;
  String dateAdd;
  String entree;
  String sortie;
  String interTime;
  String type;
  String synchro;
  String codeEntrep;

  ModelPause({
    this.code,
    this.codeAgent,
    this.dateAdd,
    this.entree,
    this.sortie,
    this.interTime,
    this.type,
    this.codeEntrep,
    this.synchro,
  });

  ModelPause.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    codeAgent = json['codeAgent'];
    dateAdd = json['dateAdd'];
    entree = json['entree'];
    sortie = json['sortie'];
    interTime = json['interTime'];
    codeEntrep = json['codeEntrep'];
    type = json['type'];
    synchro = json['synchro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['codeAgent'] = this.codeAgent;
    data['dateAdd'] = this.dateAdd;
    data['entree'] = this.entree;
    data['sortie'] = this.sortie;
    data['interTime'] = this.interTime;
    data['codeEntrep'] = this.codeEntrep;
    data['type'] = this.type;
    data['synchro'] = this.synchro;
    return data;
  }
}
