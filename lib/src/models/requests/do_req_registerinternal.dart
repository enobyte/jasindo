class ReqRegistrationInternal {
  final String cardNumber;
  final String birthDate;
  final String email;
  final String name;
  final String password;
  final String activeCode;
  final String phone;

  ReqRegistrationInternal(
      {this.cardNumber,
      this.birthDate,
      this.email,
      this.name,
      this.password,
      this.activeCode,
      this.phone});

  factory ReqRegistrationInternal.fromJson(Map<String, dynamic> json) {
    return ReqRegistrationInternal(
      cardNumber: json['card_number'],
      birthDate: json['birth_date'],
      email: json['email'],
      name: json['name'],
      password: json['password'],
      activeCode: json['active_code'],
      phone: json['phone'],
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
    return map;
  }
}
