import 'package:json_annotation/json_annotation.dart';

part 'dependent_model.g.dart';

@JsonSerializable()
class DependentModels {
  String message;
  bool status;
  int code;
  List<_Data> data;

  DependentModels({this.message, this.status, this.data, this.code});

  factory DependentModels.fromJson(Map<String, dynamic> json) =>
      _$DependentModelsFromJson(json);

  Map<String, dynamic> toJson() => _$DependentModelsToJson(this);

  DependentModels.withError(String error)
      : message = error,
        status = false;
}

@JsonSerializable()
class _Data {
  @JsonKey(name: 'FullName')
  String name;
  @JsonKey(name: 'PayorInfo')
  String payorInfo;
  @JsonKey(name: 'CorporateInfo')
  String corporateInfo;
  @JsonKey(name: 'PolicyNumber')
  String policyNumber;
  @JsonKey(name: 'BirthDate')
  String bateOfBirth;
  @JsonKey(name: 'MemberId')
  String memberId;
  @JsonKey(name: 'MemberType')
  String memberType;
  @JsonKey(name: 'PayorMemberId')
  String payorMemberId;
  @JsonKey(name: 'EmployeeId')
  String employeeId;
  @JsonKey(name: 'DependentId')
  String dependentId;
  @JsonKey(name: 'CardNo')
  String cardNo;
  @JsonKey(name: 'ResponseCode')
  String responseCode;
  @JsonKey(name: 'ResponseDescription')
  String responseDescription;

  _Data(
      {this.name,
      this.payorInfo,
      this.corporateInfo,
      this.policyNumber,
      this.bateOfBirth,
      this.memberId,
      this.memberType,
      this.payorMemberId,
      this.employeeId,
      this.dependentId,
      this.cardNo,
      this.responseCode,
      this.responseDescription});

  factory _Data.fromJson(Map<String, dynamic> json) => _$_DataFromJson(json);

  Map<String, dynamic> toJson() => _$_DataToJson(this);
}
