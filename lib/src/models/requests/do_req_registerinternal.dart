class ReqRegistrationInternal {
  final String cardNumber;
  final String birthDate;
  final String email;
  final String name;
  final String password;
  final String activeCode;
  final String phone;
  final String firebaseToken;

  ReqRegistrationInternal(
      {this.cardNumber,
      this.birthDate,
      this.email,
      this.name,
      this.password,
      this.activeCode,
      this.phone,
      this.firebaseToken});

  factory ReqRegistrationInternal.fromJson(Map<String, dynamic> json) {
    return ReqRegistrationInternal(
      cardNumber: json['card_number'],
      birthDate: json['birth_date'],
      email: json['email'],
      name: json['name'],
      password: json['password'],
      activeCode: json['active_code'],
      phone: json['phone'],
      firebaseToken: json['firebase_token'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["card_number"] = cardNumber;
    map["birth_date"] = birthDate;
    map["email"] = email;
    map["name"] = name;
    map["password"] = password;
    map["active_code"] = activeCode;
    map["phone"] = phone;
    map["firebase_token"] = firebaseToken;
    return map;
  }
}
