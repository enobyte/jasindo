import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  dynamic is_active;
  String app;
  String id;
  String admission_date;
  String provider_name;
  String message_code;
  String message_desc;
  String timestamp;
  String claim_id;

  NotificationModel(this.is_active, this.app, this.id, this.admission_date,
      this.provider_name, this.message_code, this.message_desc, this.timestamp, this.claim_id);

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
