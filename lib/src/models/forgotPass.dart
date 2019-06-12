import 'package:json_annotation/json_annotation.dart';

part 'forgotPass.g.dart';

@JsonSerializable()
class ForgotPassModels {
  String message;
  bool status;
  String data;

  ForgotPassModels(this.message, this.status, this.data);

  factory ForgotPassModels.fromJson(Map<String, dynamic> json) =>
      _$ForgotPassModelsFromJson(json);
}
