// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgotPass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPassModels _$ForgotPassModelsFromJson(Map<String, dynamic> json) {
  return ForgotPassModels(json['message'] as String, json['status'] as bool,
      json['data'] as String);
}

Map<String, dynamic> _$ForgotPassModelsToJson(ForgotPassModels instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'data': instance.data
    };
