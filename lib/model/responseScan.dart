import 'package:json_annotation/json_annotation.dart';
import 'package:v2/model/modelPresence.dart';
part 'responseScan.g.dart';

@JsonSerializable()
class ResponseScan {
  String code;
  String message;
  ModelPresence data;
  ResponseScan({this.code, this.message, this.data});

  factory ResponseScan.fromJson(Map<String, dynamic> json) =>
      _$ResponseScanFromJson(json);
}
