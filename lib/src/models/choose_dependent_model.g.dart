// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choose_dependent_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChooseDependent _$ChooseDependentFromJson(Map<String, dynamic> json) {
  return ChooseDependent(
      name: json['FullName'] as String,
      payorInfo: json['PayorInfo'] as String,
      corporateInfo: json['CorporateInfo'] as String,
      policyNumber: json['PolicyNumber'] as String,
      bateOfBirth: json['BirthDate'] as String,
      memberId: json['MemberId'] as String,
      memberType: json['MemberType'] as String,
      employeeId: json['EmployeeId'] as String,
      dependentId: json['DependentId'] as String,
      cardNo: json['CardNo'] as String,
      responseCode: json['ResponseCode'] as String,
      responseDescription: json['ResponseDescription'] as String);
}

Map<String, dynamic> _$ChooseDependentToJson(ChooseDependent instance) =>
    <String, dynamic>{
      'FullName': instance.name,
      'PayorInfo': instance.payorInfo,
      'CorporateInfo': instance.corporateInfo,
      'PolicyNumber': instance.policyNumber,
      'BirthDate': instance.bateOfBirth,
      'MemberId': instance.memberId,
      'MemberType': instance.memberType,
      'EmployeeId': instance.employeeId,
      'DependentId': instance.dependentId,
      'CardNo': instance.cardNo,
      'ResponseCode': instance.responseCode,
      'ResponseDescription': instance.responseDescription
    };
