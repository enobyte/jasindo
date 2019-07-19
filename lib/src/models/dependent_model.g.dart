// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dependent_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DependentModels _$DependentModelsFromJson(Map<String, dynamic> json) {
  return DependentModels(
      message: json['message'] as String,
      status: json['status'] as bool,
      data: (json['data'] as List)
          ?.map((e) =>
              e == null ? null : _Data.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      code: json['code'] as int);
}

Map<String, dynamic> _$DependentModelsToJson(DependentModels instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'code': instance.code,
      'data': instance.data
    };

_Data _$_DataFromJson(Map<String, dynamic> json) {
  return _Data(
      name: json['FullName'] as String,
      payorInfo: json['PayorInfo'] as String,
      corporateInfo: json['CorporateInfo'] as String,
      policyNumber: json['PolicyNumber'] as String,
      bateOfBirth: json['BirthDate'] as String,
      memberId: json['MemberId'] as String,
      memberType: json['MemberType'] as String,
      payorMemberId: json['PayorMemberId'] as String,
      employeeId: json['EmployeeId'] as String,
      dependentId: json['DependentId'] as String,
      cardNo: json['CardNo'] as String,
      responseCode: json['ResponseCode'] as String,
      responseDescription: json['ResponseDescription'] as String);
}

Map<String, dynamic> _$_DataToJson(_Data instance) => <String, dynamic>{
      'FullName': instance.name,
      'PayorInfo': instance.payorInfo,
      'CorporateInfo': instance.corporateInfo,
      'PolicyNumber': instance.policyNumber,
      'BirthDate': instance.bateOfBirth,
      'MemberId': instance.memberId,
      'MemberType': instance.memberType,
      'PayorMemberId': instance.payorMemberId,
      'EmployeeId': instance.employeeId,
      'DependentId': instance.dependentId,
      'CardNo': instance.cardNo,
      'ResponseCode': instance.responseCode,
      'ResponseDescription': instance.responseDescription
    };
