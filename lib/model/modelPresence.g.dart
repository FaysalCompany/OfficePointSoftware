// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelPresence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelPresence _$ModelPresenceFromJson(Map<String, dynamic> json) {
  return ModelPresence(
    code: json['code'] as String,
    codeAgent: json['codeAgent'] as String,
    id: json['id'] as String,
    nom: json['nom'] as String,
    fonction: json['fonction'] as String,
    agence_root: json['agence_root'] as String,
    sexe: json['sexe'] as String,
    type: json['type'] as String,
    entree: json['entree'] as String,
    sortie: json['sortie'] as String,
    justification: json['justification'] as String,
    codeEntrep: json['codeEntrep'] as String,
    retard: json['retard'] as String,
    date: json['date'] as String,
    equart: json['equart'] as String,
    prestation: json['prestation'] as String,
    agences_presence: json['agences_presence'] as String,
    adresse: json['adresse'] as String,
    image: json['image'] as String,
  );
}

Map<String, dynamic> _$ModelPresenceToJson(ModelPresence instance) =>
    <String, dynamic>{
      'code': instance.code,
      'codeAgent': instance.codeAgent,
      'id': instance.id,
      'nom': instance.nom,
      'fonction': instance.fonction,
      'agence_root': instance.agence_root,
      'sexe': instance.sexe,
      'type': instance.type,
      'entree': instance.entree,
      'sortie': instance.sortie,
      'justification': instance.justification,
      'codeEntrep': instance.codeEntrep,
      'retard': instance.retard,
      'date': instance.date,
      'equart': instance.equart,
      'prestation': instance.prestation,
      'agences_presence': instance.agences_presence,
      'adresse': instance.adresse,
      'image': instance.image,
    };
