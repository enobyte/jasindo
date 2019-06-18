import 'package:json_annotation/json_annotation.dart';
part 'get_provider.g.dart';

@JsonSerializable()
class GetProviderModel {
  String message;
  bool status;
  int errorCode;
  List<_Data> data;

  GetProviderModel({this.message, this.status, this.errorCode, this.data});

  factory GetProviderModel.fromJson(Map<String, dynamic> json) =>
      _$GetProviderModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetProviderModelToJson(this);

  GetProviderModel.withError(String error)
      : message = error,
        status = false;
}

@JsonSerializable()
class _Data {
  @JsonKey(name: 'ProviderId')
  String providerId;

  @JsonKey(name: 'ProviderName')
  String providerName;

  @JsonKey(name: 'ProviderCity')
  String providerCity;

  @JsonKey(name: 'ProviderAddress')
  String providerAddress;

  @JsonKey(name: 'ProviderPhoneNum')
  String providerPhoneNum;

  @JsonKey(name: 'LongituteLatitute')
  String longituteLatitute;

  @JsonKey(name: 'ResponseCode')
  String responseCode;

  @JsonKey(name: 'ResponseDescription')
  String responseDescription;

  @JsonKey(name: 'Distance')
  String distance;

  _Data(this.providerId, this.providerName, this.providerCity,
      this.providerAddress, this.providerPhoneNum, this.longituteLatitute,
      this.responseCode, this.responseDescription, this.distance);

  factory _Data.fromJson(Map<String, dynamic> json) => _$_DataFromJson(json);

  Map<String, dynamic> toJson() => _$_DataToJson(this);
}
