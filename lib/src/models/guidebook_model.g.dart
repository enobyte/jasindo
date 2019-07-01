// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guidebook_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuideBookModels _$GuideBookModelsFromJson(Map<String, dynamic> json) {
  return GuideBookModels(
      message: json['message'] as String,
      status: json['status'] as bool,
      data: json['data'] == null
          ? null
          : _Data.fromJson(json['data'] as Map<String, dynamic>),
      code: json['code'] as int);
}

Map<String, dynamic> _$GuideBookModelsToJson(GuideBookModels instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'code': instance.code,
      'data': instance.data
    };

_Data _$_DataFromJson(Map<String, dynamic> json) {
  return _Data(
      planId: json['plan_id'] as String,
      url: json['url'] as String,
      isActive: json['is_active'] as bool,
      corporate: json['corporation'] as String);
}

Map<String, dynamic> _$_DataToJson(_Data instance) => <String, dynamic>{
      'plan_id': instance.planId,
      'url': instance.url,
      'is_active': instance.isActive,
      'corporation': instance.corporate
    };
