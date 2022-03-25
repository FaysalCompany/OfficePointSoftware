// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responseScan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseScan _$ResponseScanFromJson(Map<String, dynamic> json) {
  return ResponseScan(
    code: json['code'] as String,
    message: json['message'] as String,
    data: json['data'] == null
        ? null
        : ModelPresence.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResponseScanToJson(ResponseScan instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
