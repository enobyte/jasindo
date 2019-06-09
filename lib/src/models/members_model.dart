import 'package:json_annotation/json_annotation.dart';

part 'members_model.g.dart';

@JsonSerializable()
class MemberModels {
  String message;
  bool status;
  _Data data;

  MemberModels({this.message, this.status, this.data});

  factory MemberModels.fromJson(Map<String, dynamic> json) =>
      _$MemberModelsFromJson(json);

  Map<String, dynamic> toJson() => _$MemberModelsToJson(this);
}

@JsonSerializable()
class _Data {
  _Data(
      {this.id,
      this.createAt,
      this.updateAt,
      this.deleteAt,
      this.cardNumb,
      this.birthDate,
      this.phone,
      this.email,
      this.name,
      this.firebaseToken,
      this.token,
      this.photo});

  @JsonKey(name: 'ID')
  int id;
  @JsonKey(name: 'CreatedAt')
  String createAt;
  @JsonKey(name: 'UpdatedAt')
  String updateAt;
  @JsonKey(name: 'DeletedAt')
  String deleteAt;
  @JsonKey(name: 'card_number')
  String cardNumb;
  @JsonKey(name: 'birth_date')
  String birthDate;
  @JsonKey(name: 'phone')
  int phone;
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'firebase_token')
  String firebaseToken;
  @JsonKey(name: 'token')
  String token;
  @JsonKey(name: 'image')
  String photo;

  factory _Data.fromJson(Map<String, dynamic> json) => _$_DataFromJson(json);

  Map<String, dynamic> toJson() => _$_DataToJson(this);
}