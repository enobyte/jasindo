class ReqDoLogin {
  final String email;
  final String password;
  final String app;

  ReqDoLogin({this.email, this.password, this.app});

  factory ReqDoLogin.fromJson(Map<String, dynamic> json) {
    return ReqDoLogin(
      email: json['email'],
      password: json['password'],
      app: json['app'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["email"] = email;
    map["password"] = password;
    map["app"] = app;
    return map;
  }
}
