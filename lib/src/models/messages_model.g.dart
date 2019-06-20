// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessagesModels _$MessagesModelsFromJson(Map<String, dynamic> json) {
  return MessagesModels(
      message: json['message'] as String,
      status: json['status'] as bool,
      data: json['data'] == null
          ? null
          : _Data.fromJson(json['data'] as Map<String, dynamic>),
      code: json['code'] as int);
}

Map<String, dynamic> _$MessagesModelsToJson(MessagesModels instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'code': instance.code,
      'data': instance.data
    };

_Data _$_DataFromJson(Map<String, dynamic> json) {
  return _Data(
      id: json['id'] as String,
      email: json['email'] as String,
      subject: json['subject'] as String,
      create_at: json['create_at'] as String);
}

Map<String, dynamic> _$_DataToJson(_Data instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'subject': instance.subject,
      'create_at': instance.create_at
    };
