// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsModel _$NewsModelFromJson(Map<String, dynamic> json) {
  return NewsModel(
      message: json['message'] as String,
      status: json['status'] as bool,
      data: (json['data'] as List)
          ?.map((e) =>
              e == null ? null : _Data.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      code: json['code'] as int,
      version: json['version'] == null
          ? null
          : _Version.fromJson(json['version'] as Map<String, dynamic>));
}

Map<String, dynamic> _$NewsModelToJson(NewsModel instance) => <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'version': instance.version
    };

_Data _$_DataFromJson(Map<String, dynamic> json) {
  return _Data(
      id: json['id'] as int,
      content: json['content'] as String,
      images: json['images'] as String,
      createat: json['createat'] as String)
    ..title = json['title'] as String;
}

Map<String, dynamic> _$_DataToJson(_Data instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'images': instance.images,
      'createat': instance.createat,
      'title': instance.title
    };

_Version _$_VersionFromJson(Map<String, dynamic> json) {
  return _Version(
      json['id'] as int,
      json['app'] as String,
      json['version_code'] as String,
      json['platform'] as String,
      json['version_name'] as String);
}

Map<String, dynamic> _$_VersionToJson(_Version instance) => <String, dynamic>{
      'id': instance.id,
      'app': instance.app,
      'version_code': instance.version_code,
      'platform': instance.platform,
      'version_name': instance.version_name
    };
