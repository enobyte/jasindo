class ReqDoResendCode {
  final String email;

  ReqDoResendCode({this.email});

  factory ReqDoResendCode.fromJson(Map<String, dynamic> json) {
    return ReqDoResendCode(
      email: json['email'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["email"] = email;
    return map;
  }
}
