import 'package:json_annotation/json_annotation.dart';

part 'members_model.g.dart';

@JsonSerializable()
class MemberModels {
  String message;
  bool status;
  _Data data;
  _Adcps adcps;

  MemberModels({this.message, this.status, this.data, this.adcps});

  factory MemberModels.fromJson(Map<String, dynamic> json) =>
      _$MemberModelsFromJson(json);

  Map<String, dynamic> toJson() => _$MemberModelsToJson(this);

  MemberModels.withError(String error)
      : message = error,
        status = false;
}

@JsonSerializable()
class _Data {
  _Data(
      {this.id,
      this.createAt,
      this.updateAt,
      this.deleteAt,
      this.cardNumb,
      this.birthDate,
      this.phone,
      this.email,
      this.name,
      this.firebaseToken,
      this.token,
      this.photo,
      this.isActive,
      this.activeCode});

  @JsonKey(name: 'ID')
  int id;
  @JsonKey(name: 'CreatedAt')
  String createAt;
  @JsonKey(name: 'UpdatedAt')
  String updateAt;
  @JsonKey(name: 'DeletedAt')
  String deleteAt;
  @JsonKey(name: 'card_number')
  String cardNumb;
  @JsonKey(name: 'birth_date')
  String birthDate;
  @JsonKey(name: 'phone')
  String phone;
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'firebase_token')
  String firebaseToken;
  @JsonKey(name: 'token')
  String token;
  @JsonKey(name: 'image')
  String photo;
  @JsonKey(name: 'is_active')
  bool isActive;
  @JsonKey(name: 'active_code')
  String activeCode;

  factory _Data.fromJson(Map<String, dynamic> json) => _$_DataFromJson(json);

  Map<String, dynamic> toJson() => _$_DataToJson(this);
}

@JsonSerializable()
class _Adcps {
  _Adcps(
      {this.name,
      this.payorInfo,
      this.corporateInfo,
      this.policyNumber,
      this.bateOfBirth,
      this.memberType,
      this.employeeId,
      this.dependentId,
      this.activeFlag,
      this.helpLine,
      this.vip,
      this.responseCode,
      this.responseDescription});

  @JsonKey(name: 'FullName')
  String name;
  @JsonKey(name: 'PayorInfo')
  String payorInfo;
  @JsonKey(name: 'CorporateInfo')
  String corporateInfo;
  @JsonKey(name: 'PolicyNumber')
  String policyNumber;
  @JsonKey(name: 'DateOfBirth')
  String bateOfBirth;
  @JsonKey(name: 'MemberType')
  String memberType;
  @JsonKey(name: 'EmployeeId')
  String employeeId;
  @JsonKey(name: 'DependentId')
  String dependentId;
  @JsonKey(name: 'ActiveFlag')
  String activeFlag;
  @JsonKey(name: 'HelpLine')
  String helpLine;
  @JsonKey(name: 'VIP')
  String vip;
  @JsonKey(name: 'ResponseCode')
  String responseCode;
  @JsonKey(name: 'ResponseDescription')
  String responseDescription;

  factory _Adcps.fromJson(Map<String, dynamic> json) => _$_AdcpsFromJson(json);

  Map<String, dynamic> toJson() => _$_AdcpsToJson(this);
}
