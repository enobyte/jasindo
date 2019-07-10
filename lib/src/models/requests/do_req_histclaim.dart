class ReqGetHistClaim {
  final String cardNumber;
  final String birthDate;
  final String planId;
  final String limit;

  ReqGetHistClaim({this.cardNumber, this.birthDate, this.planId, this.limit});

  factory ReqGetHistClaim.fromJson(Map<String, dynamic> json) {
    return ReqGetHistClaim(
      cardNumber: json['card_number'],
      birthDate: json['birth_date'],
      planId: json['plan_id'],
      limit: json['limit'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["card_number"] = cardNumber;
    map["birth_date"] = birthDate;
    map["plan_id"] = planId;
    map["limit"] = limit;
    return map;
  }
}
