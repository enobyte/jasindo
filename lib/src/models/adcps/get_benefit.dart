import 'package:json_annotation/json_annotation.dart';
part 'get_benefit.g.dart';

@JsonSerializable()
class GetBenefitModel {
  String message;
  bool status;
  int errorCode;
  List<_Data> data;

  GetBenefitModel({this.message, this.status, this.errorCode, this.data});

  factory GetBenefitModel.fromJson(Map<String, dynamic> json) =>
      _$GetBenefitModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetBenefitModelToJson(this);

  GetBenefitModel.withError(String error)
      : message = error,
        status = false;
}

@JsonSerializable()
class _Data {
  _Data(
      {this.benefitName,
      this.benefitCode,
      this.benefitDescription,
      this.maxIdr,
      this.available,
      this.frequencyDesc,
      this.responseCode,
      this.responseDescription});

  @JsonKey(name: 'BenefitName')
  String benefitName;

  @JsonKey(name: 'BenefitCode')
  String benefitCode;

  @JsonKey(name: 'BenefitDescription')
  String benefitDescription;

  @JsonKey(name: 'MaxIdr')
  String maxIdr;

  @JsonKey(name: 'Available')
  String available;

  @JsonKey(name: 'FrequencyDesc')
  String frequencyDesc;

  @JsonKey(name: 'ResponseCode')
  String responseCode;

  @JsonKey(name: 'ResponseDescription')
  String responseDescription;

  factory _Data.fromJson(Map<String, dynamic> json) => _$_DataFromJson(json);

  Map<String, dynamic> toJson() => _$_DataToJson(this);
}
