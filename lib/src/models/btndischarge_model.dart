import 'package:json_annotation/json_annotation.dart';

part 'btndischarge_model.g.dart';

@JsonSerializable()
class BtnDischargeModel {
  int code;
  BtnDischarge data;
  String message;
  bool status;

  BtnDischargeModel(this.code, this.data, this.message, this.status);

  factory BtnDischargeModel.fromJson(Map<String, dynamic> json) =>
      _$BtnDischargeModelFromJson(json);

  Map<String, dynamic> toJson() => _$BtnDischargeModelToJson(this);
}

@JsonSerializable()
class BtnDischarge {
  String is_active;
  String notification_app;
  String id;
  String admission_date;
  String provider_name;
  String message_code;
  String message_desc;
  String timestamp;
  String claim_id;
  String card_no;
  String title;

  BtnDischarge(
      this.is_active,
      this.notification_app,
      this.id,
      this.admission_date,
      this.provider_name,
      this.message_code,
      this.message_desc,
      this.timestamp,
      this.claim_id,
      this.card_no,
      this.title);

  factory BtnDischarge.fromJson(Map<String, dynamic> json) =>
      _$BtnDischargeFromJson(json);

  Map<String, dynamic> toJson() => _$BtnDischargeToJson(this);
}
