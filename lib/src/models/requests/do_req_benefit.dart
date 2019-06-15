class ReqGetBenefit {
  final String cardNumber;
  final String birthDate;
  final String planId;

  ReqGetBenefit({this.cardNumber, this.birthDate, this.planId});

  factory ReqGetBenefit.fromJson(Map<String, dynamic> json) {
    return ReqGetBenefit(
      cardNumber: json['card_number'],
      birthDate: json['birth_date'],
      planId: json['plan_id'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["card_number"] = cardNumber;
    map["birth_date"] = birthDate;
    map["plan_id"] = planId;
    return map;
  }
}
