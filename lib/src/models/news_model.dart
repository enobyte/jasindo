import 'package:json_annotation/json_annotation.dart';
part 'news_model.g.dart';

@JsonSerializable()
class NewsModel {
  String message;
  bool status;
  int code;
  List<_Data> data;

  NewsModel({this.message, this.status, this.data, this.code});

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);

  NewsModel.withError(String error)
      : message = error,
        status = false;
}

@JsonSerializable()
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
