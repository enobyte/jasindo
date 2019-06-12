class ReqDoForgot {
  final String email;

  ReqDoForgot({this.email});

  factory ReqDoForgot.fromJson(Map<String, dynamic> json) {
    return ReqDoForgot(
      email: json['email'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["email"] = email;
    return map;
  }
}
