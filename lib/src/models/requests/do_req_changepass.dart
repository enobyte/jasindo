class ReqChangePass {
  final String email;
  final String oldPass;
  final String newPass;

  ReqChangePass({this.email, this.oldPass, this.newPass});

  factory ReqChangePass.fromJson(Map<String, dynamic> json) {
    return ReqChangePass(
      email: json['email'],
      oldPass: json['password'],
      newPass: json['newPassword'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["email"] = email;
    map["password"] = oldPass;
    map["newPassword"] = newPass;
    return map;
  }
}
