// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'btndischarge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BtnDischargeModel _$BtnDischargeModelFromJson(Map<String, dynamic> json) {
  return BtnDischargeModel(
      json['code'] as int,
      json['data'] == null
          ? null
          : BtnDischarge.fromJson(json['data'] as Map<String, dynamic>),
      json['message'] as String,
      json['status'] as bool);
}

Map<String, dynamic> _$BtnDischargeModelToJson(BtnDischargeModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
      'status': instance.status
    };

BtnDischarge _$BtnDischargeFromJson(Map<String, dynamic> json) {
  return BtnDischarge(
      json['is_active'] as String,
      json['notification_app'] as String,
      json['id'] as String,
      json['admission_date'] as String,
      json['provider_name'] as String,
      json['message_code'] as String,
      json['message_desc'] as String,
      json['timestamp'] as String,
      json['claim_id'] as String,
      json['card_no'] as String,
      json['title'] as String);
}

Map<String, dynamic> _$BtnDischargeToJson(BtnDischarge instance) =>
    <String, dynamic>{
      'is_active': instance.is_active,
      'notification_app': instance.notification_app,
      'id': instance.id,
      'admission_date': instance.admission_date,
      'provider_name': instance.provider_name,
      'message_code': instance.message_code,
      'message_desc': instance.message_desc,
      'timestamp': instance.timestamp,
      'claim_id': instance.claim_id,
      'card_no': instance.card_no,
      'title': instance.title
    };
