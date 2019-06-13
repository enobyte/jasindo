class ReqActiveUser {
  final String email;
  final String code;

  ReqActiveUser({this.email, this.code});

  factory ReqActiveUser.fromJson(Map<String, dynamic> json) {
    return ReqActiveUser(
      email: json['email'],
      code: json['active_code'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["email"] = email;
    map["active_code"] = code;
    return map;
  }
}
