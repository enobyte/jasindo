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

  DoRegistrationModel.withError(String error)
      : message = error,
        status = false;
}

@JsonSerializable()
class _Data {
  _Data(
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
  @JsonKey(name: 'ResponseCode')
  String responseCode;
  @JsonKey(name: 'ResponseDescription')
  String responseDescription;

  factory _Data.fromJson(Map<String, dynamic> json) => _$_DataFromJson(json);

  Map<String, dynamic> toJson() => _$_DataToJson(this);
}
