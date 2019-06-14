// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'do_registration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoRegistrationModel _$DoRegistrationModelFromJson(Map<String, dynamic> json) {
  return DoRegistrationModel(
      message: json['message'] as String,
      status: json['status'] as bool,
      data: json['data'] == null
          ? null
          : _Data.fromJson(json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$DoRegistrationModelToJson(
        DoRegistrationModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'data': instance.data
    };

_Data _$_DataFromJson(Map<String, dynamic> json) {
  return _Data(
      name: json['FullName'] as String,
      payorInfo: json['PayorInfo'] as String,
      corporateInfo: json['CorporateInfo'] as String,
      policyNumber: json['PolicyNumber'] as String,
      bateOfBirth: json['DateOfBirth'] as String,
      memberType: json['MemberType'] as String,
      employeeId: json['EmployeeId'] as String,
      dependentId: json['DependentId'] as String,
      activeFlag: json['ActiveFlag'] as String,
      helpLine: json['HelpLine'] as String,
      vip: json['VIP'] as String,
      responseCode: json['ResponseCode'] as String,
      responseDescription: json['ResponseDescription'] as String);
}

Map<String, dynamic> _$_DataToJson(_Data instance) => <String, dynamic>{
      'FullName': instance.name,
      'PayorInfo': instance.payorInfo,
      'CorporateInfo': instance.corporateInfo,
      'PolicyNumber': instance.policyNumber,
      'DateOfBirth': instance.bateOfBirth,
      'MemberType': instance.memberType,
      'EmployeeId': instance.employeeId,
      'DependentId': instance.dependentId,
      'ActiveFlag': instance.activeFlag,
      'HelpLine': instance.helpLine,
      'VIP': instance.vip,
      'ResponseCode': instance.responseCode,
      'ResponseDescription': instance.responseDescription
    };
