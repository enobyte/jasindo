import 'package:json_annotation/json_annotation.dart';

part 'choose_dependent_model.g.dart';

@JsonSerializable()
class ChooseDependent {
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

  ChooseDependent(
      {this.name,
      this.payorInfo,
      this.corporateInfo,
      this.policyNumber,
      this.bateOfBirth,
      this.memberId,
      this.memberType,
      this.employeeId,
      this.dependentId,
      this.cardNo,
      this.responseCode,
      this.responseDescription});

  factory ChooseDependent.fromJson(Map<String, dynamic> json) =>
      _$ChooseDependentFromJson(json);

  Map<String, dynamic> toJson() => _$ChooseDependentToJson(this);
}
