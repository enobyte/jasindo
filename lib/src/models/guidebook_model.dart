import 'package:json_annotation/json_annotation.dart';

part 'guidebook_model.g.dart';

@JsonSerializable()
class GuideBookModels {
  String message;
  bool status;
  int code;
  _Data data;

  GuideBookModels({this.message, this.status, this.data, this.code});

  factory GuideBookModels.fromJson(Map<String, dynamic> json) =>
      _$GuideBookModelsFromJson(json);

  Map<String, dynamic> toJson() => _$GuideBookModelsToJson(this);

  GuideBookModels.withError(String error)
      : message = error,
        status = false;
}

@JsonSerializable()
class _Data {
  _Data({this.planId, this.url, this.isActive, this.corporate});

  @JsonKey(name: 'plan_id')
  String planId;
  @JsonKey(name: 'url')
  String url;
  @JsonKey(name: 'is_active')
  bool isActive;
  @JsonKey(name: 'corporation')
  String corporate;

  factory _Data.fromJson(Map<String, dynamic> json) => _$_DataFromJson(json);

  Map<String, dynamic> toJson() => _$_DataToJson(this);
}
