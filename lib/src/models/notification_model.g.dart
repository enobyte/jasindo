// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) {
  return NotificationModel(
      json['is_active'],
      json['app'] as String,
      json['id'] as String,
      json['admission_date'] as String,
      json['provider_name'] as String,
      json['message_code'] as String,
      json['message_desc'] as String,
      json['timestamp'] as String,
      json['claim_id'] as String);
}

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'is_active': instance.is_active,
      'app': instance.app,
      'id': instance.id,
      'admission_date': instance.admission_date,
      'provider_name': instance.provider_name,
      'message_code': instance.message_code,
      'message_desc': instance.message_desc,
      'timestamp': instance.timestamp,
      'claim_id': instance.claim_id
    };
