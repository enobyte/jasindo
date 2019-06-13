class ReqDoLogin {
  final String email;
  final String password;

  ReqDoLogin({this.email, this.password});

  factory ReqDoLogin.fromJson(Map<String, dynamic> json) {
    return ReqDoLogin(
      email: json['email'],
      password: json['password'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["email"] = email;
    map["password"] = password;
    return map;
  }
}
