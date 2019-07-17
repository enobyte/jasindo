import 'package:json_annotation/json_annotation.dart';

part 'information_model.g.dart';

@JsonSerializable()
class InformationModels {
  String message;
  bool status;
  int code;
  List<_Data> data;

  InformationModels({this.message, this.status, this.data, this.code});

  factory InformationModels.fromJson(Map<String, dynamic> json) =>
      _$InformationModelsFromJson(json);

  Map<String, dynamic> toJson() => _$InformationModelsToJson(this);

  InformationModels.withError(String error)
      : message = error,
        status = false;
}

@JsonSerializable()
class _Data {
  _Data({this.id, this.title, this.link, this.is_active, this.corporate});

  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'link')
  String link;
  @JsonKey(name: 'is_active')
  bool is_active;
  @JsonKey(name: 'corporate')
  List<String> corporate;

  factory _Data.fromJson(Map<String, dynamic> json) => _$_DataFromJson(json);

  Map<String, dynamic> toJson() => _$_DataToJson(this);
}
