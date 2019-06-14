import 'package:json_annotation/json_annotation.dart';
part 'get_plans.g.dart';

@JsonSerializable()
class GetPlansModel {
  String message;
  bool status;
  int errorCode;
  List<_Data> data;

  GetPlansModel({this.message, this.status, this.errorCode, this.data});

  factory GetPlansModel.fromJson(Map<String, dynamic> json) =>
      _$GetPlansModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetPlansModelToJson(this);

  GetPlansModel.withError(String error)
      : message = error,
        status = false;
}

@JsonSerializable()
class _Data {
  _Data(
      {this.planId,
      this.planType,
      this.policyStartDate,
      this.policyEndDate,
      this.recordStatus,
      this.maxIdr,
      this.frequencyDesc,
      this.currentLimit,
      this.responseCode,
      this.responseDescription});

  @JsonKey(name: 'PlanId')
  String planId;

  @JsonKey(name: 'PlanType')
  String planType;

  @JsonKey(name: 'PolicyStartDate')
  String policyStartDate;

  @JsonKey(name: 'PolicyEndDate')
  String policyEndDate;

  @JsonKey(name: 'RecordStatus')
  String recordStatus;

  @JsonKey(name: 'MaxIdr')
  String maxIdr;

  @JsonKey(name: 'FrequencyDesc')
  String frequencyDesc;

  @JsonKey(name: 'CurrentLimit')
  String currentLimit;

  @JsonKey(name: 'ResponseCode')
  String responseCode;

  @JsonKey(name: 'ResponseDescription')
  String responseDescription;

  factory _Data.fromJson(Map<String, dynamic> json) => _$_DataFromJson(json);

  Map<String, dynamic> toJson() => _$_DataToJson(this);
}
