// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_hist_claim.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetHistClaimModel _$GetHistClaimModelFromJson(Map<String, dynamic> json) {
  return GetHistClaimModel(
      message: json['message'] as String,
      status: json['status'] as bool,
      errorCode: json['errorCode'] as int,
      data: (json['data'] as List)
          ?.map((e) =>
              e == null ? null : _Data.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetHistClaimModelToJson(GetHistClaimModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'errorCode': instance.errorCode,
      'data': instance.data
    };

_Data _$_DataFromJson(Map<String, dynamic> json) {
  return _Data(
      claimId: json['ClaimId'] as String,
      status: json['Status'] as String,
      claimType: json['ClaimType'] as String,
      admissionDate: json['AdmissionDate'] as String,
      dischargeDate: json['DischargeDate'] as String,
      diagnosis: json['Diagnosis'] as String,
      providerName: json['ProviderName'] as String,
      incured: json['Incured'] as String,
      excess: json['Excess'] as String,
      approved: json['Approved'] as String,
      responseCode: json['ResponseCode'] as String,
      responseDescription: json['ResponseDescription'] as String);
}

Map<String, dynamic> _$_DataToJson(_Data instance) => <String, dynamic>{
      'ClaimId': instance.claimId,
      'Status': instance.status,
      'ClaimType': instance.claimType,
      'AdmissionDate': instance.admissionDate,
      'DischargeDate': instance.dischargeDate,
      'Diagnosis': instance.diagnosis,
      'ProviderName': instance.providerName,
      'Incured': instance.incured,
      'Excess': instance.excess,
      'Approved': instance.approved,
      'ResponseCode': instance.responseCode,
      'ResponseDescription': instance.responseDescription
    };
