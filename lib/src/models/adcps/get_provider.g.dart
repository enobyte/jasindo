// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProviderModel _$GetProviderModelFromJson(Map<String, dynamic> json) {
  return GetProviderModel(
      message: json['message'] as String,
      status: json['status'] as bool,
      errorCode: json['errorCode'] as int,
      data: (json['data'] as List)
          ?.map((e) =>
              e == null ? null : _Data.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetProviderModelToJson(GetProviderModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'errorCode': instance.errorCode,
      'data': instance.data
    };

_Data _$_DataFromJson(Map<String, dynamic> json) {
  return _Data(
      json['ProviderId'] as String,
      json['ProviderName'] as String,
      json['ProviderCity'] as String,
      json['ProviderAddress'] as String,
      json['ProviderPhoneNum'] as String,
      json['LongituteLatitute'] as String,
      json['ResponseCode'] as String,
      json['ResponseDescription'] as String,
      json['Distance'] as String);
}

Map<String, dynamic> _$_DataToJson(_Data instance) => <String, dynamic>{
      'ProviderId': instance.providerId,
      'ProviderName': instance.providerName,
      'ProviderCity': instance.providerCity,
      'ProviderAddress': instance.providerAddress,
      'ProviderPhoneNum': instance.providerPhoneNum,
      'LongituteLatitute': instance.longituteLatitute,
      'ResponseCode': instance.responseCode,
      'ResponseDescription': instance.responseDescription,
      'Distance' : instance.distance

    };
