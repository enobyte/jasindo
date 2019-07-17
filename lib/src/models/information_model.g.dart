// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'information_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InformationModels _$InformationModelsFromJson(Map<String, dynamic> json) {
  return InformationModels(
      message: json['message'] as String,
      status: json['status'] as bool,
      data: (json['data'] as List)
          ?.map((e) =>
              e == null ? null : _Data.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      code: json['code'] as int);
}

Map<String, dynamic> _$InformationModelsToJson(InformationModels instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'code': instance.code,
      'data': instance.data
    };

_Data _$_DataFromJson(Map<String, dynamic> json) {
  return _Data(
      id: json['id'] as int,
      title: json['title'] as String,
      link: json['link'] as String,
      is_active: json['is_active'] as bool,
      corporate:
          (json['corporate'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$_DataToJson(_Data instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'link': instance.link,
      'is_active': instance.is_active,
      'corporate': instance.corporate
    };
