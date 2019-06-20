import 'package:json_annotation/json_annotation.dart';

part 'abouts_model.g.dart';

@JsonSerializable()
class AboutsModels {
  String message;
  bool status;
  int code;
  List<_Data> data;

  AboutsModels({this.message, this.status, this.data, this.code});

  factory AboutsModels.fromJson(Map<String, dynamic> json) =>
      _$AboutsModelsFromJson(json);

  Map<String, dynamic> toJson() => _$AboutsModelsToJson(this);

  AboutsModels.withError(String error)
      : message = error,
        status = false;
}

@JsonSerializable()
class _Data {
  _Data({this.id, this.name, this.descriptions, this.image});

  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'descriptions')
  String descriptions;
  @JsonKey(name: 'image')
  String image;

  factory _Data.fromJson(Map<String, dynamic> json) => _$_DataFromJson(json);

  Map<String, dynamic> toJson() => _$_DataToJson(this);
}
