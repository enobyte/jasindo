import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

@JsonSerializable(nullable: true)
class NewsModel {
  String message;
  bool status;
  int code;
  List<_Data> data = [];
  _Version version;

  NewsModel({this.message, this.status, this.data, this.code, this.version});

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);

  NewsModel.withError(String error)
      : message = error,
        status = false;
}

@JsonSerializable(nullable: true)
class _Data {
  _Data({this.id, this.content, this.images, this.createat});

  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'content')
  String content;
  @JsonKey(name: 'images')
  String images;
  @JsonKey(name: 'createat')
  String createat;
  @JsonKey(name: 'title')
  String title;

  factory _Data.fromJson(Map<String, dynamic> json) => _$_DataFromJson(json);

  Map<String, dynamic> toJson() => _$_DataToJson(this);
}

@JsonSerializable()
class _Version {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'app')
  String app;
  @JsonKey(name: 'version_code')
  String version_code;
  @JsonKey(name: 'platform')
  String platform;
  @JsonKey(name: 'version_name')
  String version_name;

  _Version(
      this.id, this.app, this.version_code, this.platform, this.version_name);

  factory _Version.fromJson(Map<String, dynamic> json) =>
      _$_VersionFromJson(json);

  Map<String, dynamic> toJson() => _$_VersionToJson(this);
}
