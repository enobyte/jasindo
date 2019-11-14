class ReqDoLogin {
  final String email;
  final String password;
  final String firebaseToken;
  final String app;

  ReqDoLogin({this.email, this.password, this.app, this.firebaseToken});

  factory ReqDoLogin.fromJson(Map<String, dynamic> json) {
    return ReqDoLogin(
      email: json['email'],
      password: json['password'],
      firebaseToken: json['firebase_token'],
      app: json['app'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["email"] = email;
    map["password"] = password;
    map["firebase_token"] = firebaseToken;
    map["app"] = app;
    return map;
  }
}
