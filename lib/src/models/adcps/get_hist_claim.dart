import 'package:json_annotation/json_annotation.dart';

part 'get_hist_claim.g.dart';

@JsonSerializable()
class GetHistClaimModel {
  String message;
  bool status;
  int errorCode;
  List<_Data> data;

  GetHistClaimModel({this.message, this.status, this.errorCode, this.data});

  factory GetHistClaimModel.fromJson(Map<String, dynamic> json) =>
      _$GetHistClaimModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetHistClaimModelToJson(this);

  GetHistClaimModel.withError(String error)
      : message = error,
        status = false;
}

@JsonSerializable()
class _Data {
  @JsonKey(name: 'ClaimId')
  String claimId;

  @JsonKey(name: 'Status')
  String status;

  @JsonKey(name: 'ClaimType')
  String claimType;

  @JsonKey(name: 'AdmissionDate')
  String admissionDate;

  @JsonKey(name: 'DischargeDate')
  String dischargeDate;

  @JsonKey(name: 'Diagnosis')
  String diagnosis;

  @JsonKey(name: 'ProviderName')
  String providerName;

  @JsonKey(name: 'Incured')
  String incured;

  @JsonKey(name: 'Excess')
  String excess;

  @JsonKey(name: 'Approved')
  String approved;

  @JsonKey(name: 'ResponseCode')
  String responseCode;

  @JsonKey(name: 'ResponseDescription')
  String responseDescription;

  _Data(
      {this.claimId,
      this.status,
      this.claimType,
      this.admissionDate,
      this.dischargeDate,
      this.diagnosis,
      this.providerName,
      this.incured,
      this.excess,
      this.approved,
      this.responseCode,
      this.responseDescription});

  factory _Data.fromJson(Map<String, dynamic> json) => _$_DataFromJson(json);

  Map<String, dynamic> toJson() => _$_DataToJson(this);
}
