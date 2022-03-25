class ModelTypeagent {
  String code;
  String designation;
  String dateAdd;
  String codeEntrep;
  String synchro;

  ModelTypeagent(
      {this.code,
      this.designation,
      this.dateAdd,
      this.codeEntrep,
      this.synchro});

  ModelTypeagent.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    designation = json['designation'];
    dateAdd = json['dateAdd'];
    codeEntrep = json['codeEntrep'];
    synchro = json['synchro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['designation'] = this.designation;
    data['dateAdd'] = this.dateAdd;
    data['codeEntrep'] = this.codeEntrep;
    data['synchro'] = this.synchro;
    return data;
  }
}
