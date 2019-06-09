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
          : _Data.fromJson(json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$MemberModelsToJson(MemberModels instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'data': instance.data
    };

_Data _$_DataFromJson(Map<String, dynamic> json) {
  return _Data(
      id: json['ID'] as int,
      createAt: json['CreatedAt'] as String,
      updateAt: json['UpdatedAt'] as String,
      deleteAt: json['DeletedAt'] as String,
      cardNumb: json['card_number'] as String,
      birthDate: json['birth_date'] as String,
      phone: json['phone'] as int,
      email: json['email'] as String,
      name: json['name'] as String,
      firebaseToken: json['firebase_token'] as String,
      token: json['token'] as String,
      photo: json['image'] as String);
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
      'image': instance.photo
    };
