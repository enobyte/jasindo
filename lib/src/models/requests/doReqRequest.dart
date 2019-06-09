class ReqDoRegistration {
  final String cardNumber;
  final String birthDate;
  final String email;

  ReqDoRegistration({this.cardNumber, this.birthDate, this.email});

  factory ReqDoRegistration.fromJson(Map<String, dynamic> json) {
    return ReqDoRegistration(
      cardNumber: json['card_number'],
      birthDate: json['birth_date'],
      email: json['email'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["card_number"] = cardNumber;
    map["birth_date"] = birthDate;
    map["email"] = email;

    return map;
  }
}
