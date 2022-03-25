class ModelFonction {
  String code;
  String codeEntrep;
  String designation;
  String dateAdd;
  String synchro;

  ModelFonction(
      {this.code,
      this.codeEntrep,
      this.designation,
      this.dateAdd,
      this.synchro});

  ModelFonction.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    codeEntrep = json['codeEntrep'];
    designation = json['designation'];
    dateAdd = json['dateAdd'];
    synchro = json['synchro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['codeEntrep'] = this.codeEntrep;
    data['designation'] = this.designation;
    data['dateAdd'] = this.dateAdd;
    data['synchro'] = this.synchro;
    return data;
  }
}
