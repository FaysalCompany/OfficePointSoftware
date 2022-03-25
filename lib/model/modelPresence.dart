import 'package:json_annotation/json_annotation.dart';
part 'modelPresence.g.dart';

@JsonSerializable()
class ModelPresence {
  String code;
  String codeAgent;
  String id;
  String nom;
  String fonction;
  String agence_root;
  String sexe;
  String type;
  String entree;
  String sortie;
  String justification;
  String codeEntrep;
  String retard;
  String date;
  String equart;
  String prestation;
  String agences_presence;
  String adresse;
  String image;

  ModelPresence({
    this.code,
    this.codeAgent,
    this.id,
    this.nom,
    this.fonction,
    this.agence_root,
    this.sexe,
    this.type,
    this.entree,
    this.sortie,
    this.justification,
    this.codeEntrep,
    this.retard,
    this.date,
    this.equart,
    this.prestation,
    this.agences_presence,
    this.adresse,
    this.image,
  });

  factory ModelPresence.fromJson(Map<String, dynamic> json) =>
      _$ModelPresenceFromJson(json);
}
