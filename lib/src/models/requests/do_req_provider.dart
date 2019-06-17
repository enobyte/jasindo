class ReqGetProvider {
  final String cardNumber;
  final String birthDate;
  final String planId;
  final String city;

  ReqGetProvider({this.cardNumber, this.birthDate, this.planId, this.city});

  factory ReqGetProvider.fromJson(Map<String, dynamic> json) {
    return ReqGetProvider(
      cardNumber: json['card_number'],
      birthDate: json['birth_date'],
      planId: json['plan_id'],
      city: json['city'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["card_number"] = cardNumber;
    map["birth_date"] = birthDate;
    map["plan_id"] = planId;
    map["city"] = city;
    return map;
  }
}
