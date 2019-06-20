import 'package:json_annotation/json_annotation.dart';

part 'messages_model.g.dart';

@JsonSerializable()
class MessagesModels {
  String message;
  bool status;
  int code;
  _Data data;

  MessagesModels({this.message, this.status, this.data, this.code});

  factory MessagesModels.fromJson(Map<String, dynamic> json) =>
      _$MessagesModelsFromJson(json);

  Map<String, dynamic> toJson() => _$MessagesModelsToJson(this);

  MessagesModels.withError(String error)
      : message = error,
        status = false;
}

@JsonSerializable()
class _Data {
  _Data({this.id, this.email, this.subject, this.create_at});

  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'subject')
  String subject;
  @JsonKey(name: 'create_at')
  String create_at;

  factory _Data.fromJson(Map<String, dynamic> json) => _$_DataFromJson(json);

  Map<String, dynamic> toJson() => _$_DataToJson(this);
}
