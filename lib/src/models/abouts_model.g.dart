// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'abouts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AboutsModels _$AboutsModelsFromJson(Map<String, dynamic> json) {
  return AboutsModels(
      message: json['message'] as String,
      status: json['status'] as bool,
      data: (json['data'] as List)
          ?.map((e) =>
              e == null ? null : _Data.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      code: json['code'] as int);
}

Map<String, dynamic> _$AboutsModelsToJson(AboutsModels instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'code': instance.code,
      'data': instance.data
    };

_Data _$_DataFromJson(Map<String, dynamic> json) {
  return _Data(
      id: json['id'] as int,
      name: json['name'] as String,
      descriptions: json['descriptions'] as String,
      image: json['image'] as String);
}

Map<String, dynamic> _$_DataToJson(_Data instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'descriptions': instance.descriptions,
      'image': instance.image
    };
