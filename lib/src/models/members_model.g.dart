// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'members_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberModels _$MemberModelsFromJson(Map<String, dynamic> json) {
  return MemberModels(
      message: json['message'] as String,
      status: json['status'] as bool,
      data: json['data'] == null
          ? null
          : _Data.fromJson(json['data'] as Map<String, dynamic>),
      adcps: json['adcps'] == null
          ? null
          : _Adcps.fromJson(json['adcps'] as Map<String, dynamic>));
}

Map<String, dynamic> _$MemberModelsToJson(MemberModels instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'data': instance.data,
      'adcps': instance.adcps
    };

_Data _$_DataFromJson(Map<String, dynamic> json) {
  return _Data(
      id: json['ID'] as int,
      createAt: json['CreatedAt'] as String,
      updateAt: json['UpdatedAt'] as String,
      deleteAt: json['DeletedAt'] as String,
      cardNumb: json['card_number'] as String,
      birthDate: json['birth_date'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      firebaseToken: json['firebase_token'] as String,
      token: json['token'] as String,
      photo: json['image'] as String,
      isActive: json['is_active'] as bool,
      activeCode: json['active_code'] as String);
}

Map<String, dynamic> _$_DataToJson(_Data instance) => <String, dynamic>{
      'ID': instance.id,
      'CreatedAt': instance.createAt,
      'UpdatedAt': instance.updateAt,
      'DeletedAt': instance.deleteAt,
      'card_number': instance.cardNumb,
      'birth_date': instance.birthDate,
      'phone': instance.phone,
      'email': instance.email,
      'name': instance.name,
      'firebase_token': instance.firebaseToken,
      'token': instance.token,
      'image': instance.photo,
      'is_active': instance.isActive,
      'active_code': instance.activeCode
    };

_Adcps _$_AdcpsFromJson(Map<String, dynamic> json) {
  return _Adcps(
      name: json['FullName'] as String,
      payorInfo: json['PayorInfo'] as String,
      corporateInfo: json['CorporateInfo'] as String,
      policyNumber: json['PolicyNumber'] as String,
      bateOfBirth: json['DateOfBirth'] as String,
      memberType: json['MemberType'] as String,
      memberId: json['PayorMemberId'] as String,
      employeeId: json['EmployeeId'] as String,
      dependentId: json['DependentId'] as String,
      activeFlag: json['ActiveFlag'] as String,
      helpLine: json['HelpLine'] as String,
      vip: json['VIP'] as String,
      responseCode: json['ResponseCode'] as String,
      responseDescription: json['ResponseDescription'] as String);
}

Map<String, dynamic> _$_AdcpsToJson(_Adcps instance) => <String, dynamic>{
      'FullName': instance.name,
      'PayorInfo': instance.payorInfo,
      'CorporateInfo': instance.corporateInfo,
      'PolicyNumber': instance.policyNumber,
      'DateOfBirth': instance.bateOfBirth,
      'MemberType': instance.memberType,
      'PayorMemberId': instance.memberId,
      'EmployeeId': instance.employeeId,
      'DependentId': instance.dependentId,
      'ActiveFlag': instance.activeFlag,
      'HelpLine': instance.helpLine,
      'VIP': instance.vip,
      'ResponseCode': instance.responseCode,
      'ResponseDescription': instance.responseDescription
    };
