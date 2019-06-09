import 'package:json_annotation/json_annotation.dart';

part 'do_registration.g.dart';

@JsonSerializable()
class DoRegistrationModel {
  String message;
  bool status;
  _Data data;

  DoRegistrationModel({this.message, this.status, this.data});

  factory DoRegistrationModel.fromJson(Map<String, dynamic> json) =>
      _$DoRegistrationModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoRegistrationModelToJson(this);
}

@JsonSerializable()
class _Data {

  _Data(
      {this.name,
      this.payorInfo,
      this.corporateInfo,
      this.policyNumber,
      this.memberId,
      this.payorMemberId,
      this.memberType,
      this.employeeId,
      this.dependentId,
      this.activeFlag,
      this.corporateRemarks,
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
  @JsonKey(name: 'MemberId')
  String memberId;
  @JsonKey(name: 'PayorMemberId')
  String payorMemberId;
  @JsonKey(name: 'MemberType')
  String memberType;
  @JsonKey(name: 'EmployeeId')
  String employeeId;
  @JsonKey(name: 'DependentId')
  String dependentId;
  @JsonKey(name: 'ActiveFlag')
  String activeFlag;
  @JsonKey(name: 'CorporateRemarks')
  String corporateRemarks;
  @JsonKey(name: 'ResponseCode')
  String responseCode;
  @JsonKey(name: 'ResponseDescription')
  String responseDescription;

  factory _Data.fromJson(Map<String, dynamic> json) => _$_DataFromJson(json);

  Map<String, dynamic> toJson() => _$_DataToJson(this);
}
