class ReqGetPlan {
  final String cardNumber;
  final String birthDate;

  ReqGetPlan({this.cardNumber, this.birthDate});

  factory ReqGetPlan.fromJson(Map<String, dynamic> json) {
    return ReqGetPlan(
      cardNumber: json['card_number'],
      birthDate: json['birth_date'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["card_number"] = cardNumber;
    map["birth_date"] = birthDate;
    return map;
  }
}
