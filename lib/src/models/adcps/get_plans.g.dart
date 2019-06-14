// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_plans.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPlansModel _$GetPlansModelFromJson(Map<String, dynamic> json) {
  return GetPlansModel(
      message: json['message'] as String,
      status: json['status'] as bool,
      errorCode: json['errorCode'] as int,
      data: (json['data'] as List)
          ?.map((e) =>
              e == null ? null : _Data.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetPlansModelToJson(GetPlansModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'errorCode': instance.errorCode,
      'data': instance.data
    };

_Data _$_DataFromJson(Map<String, dynamic> json) {
  return _Data(
      planId: json['PlanId'] as String,
      planType: json['PlanType'] as String,
      policyStartDate: json['PolicyStartDate'] as String,
      policyEndDate: json['PolicyEndDate'] as String,
      recordStatus: json['RecordStatus'] as String,
      maxIdr: json['MaxIdr'] as String,
      frequencyDesc: json['FrequencyDesc'] as String,
      currentLimit: json['CurrentLimit'] as String,
      responseCode: json['ResponseCode'] as String,
      responseDescription: json['ResponseDescription'] as String);
}

Map<String, dynamic> _$_DataToJson(_Data instance) => <String, dynamic>{
      'PlanId': instance.planId,
      'PlanType': instance.planType,
      'PolicyStartDate': instance.policyStartDate,
      'PolicyEndDate': instance.policyEndDate,
      'RecordStatus': instance.recordStatus,
      'MaxIdr': instance.maxIdr,
      'FrequencyDesc': instance.frequencyDesc,
      'CurrentLimit': instance.currentLimit,
      'ResponseCode': instance.responseCode,
      'ResponseDescription': instance.responseDescription
    };
