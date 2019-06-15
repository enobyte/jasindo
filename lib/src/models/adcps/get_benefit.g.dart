// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_benefit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBenefitModel _$GetBenefitModelFromJson(Map<String, dynamic> json) {
  return GetBenefitModel(
      message: json['message'] as String,
      status: json['status'] as bool,
      errorCode: json['errorCode'] as int,
      data: (json['data'] as List)
          ?.map((e) =>
              e == null ? null : _Data.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetBenefitModelToJson(GetBenefitModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'errorCode': instance.errorCode,
      'data': instance.data
    };

_Data _$_DataFromJson(Map<String, dynamic> json) {
  return _Data(
      benefitName: json['BenefitName'] as String,
      benefitCode: json['BenefitCode'] as String,
      benefitDescription: json['BenefitDescription'] as String,
      maxIdr: json['MaxIdr'] as String,
      available: json['Available'] as String,
      frequencyDesc: json['FrequencyDesc'] as String,
      responseCode: json['ResponseCode'] as String,
      responseDescription: json['ResponseDescription'] as String);
}

Map<String, dynamic> _$_DataToJson(_Data instance) => <String, dynamic>{
      'BenefitName': instance.benefitName,
      'BenefitCode': instance.benefitCode,
      'BenefitDescription': instance.benefitDescription,
      'MaxIdr': instance.maxIdr,
      'Available': instance.available,
      'FrequencyDesc': instance.frequencyDesc,
      'ResponseCode': instance.responseCode,
      'ResponseDescription': instance.responseDescription
    };
