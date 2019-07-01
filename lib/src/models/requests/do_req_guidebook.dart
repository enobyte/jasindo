class ReqGetGuideBook {
  final String cardNumber;
  final String birthDate;
  final bool isPlan;
  final String corporate;

  ReqGetGuideBook(
      {this.cardNumber, this.birthDate, this.isPlan, this.corporate});

  factory ReqGetGuideBook.fromJson(Map<String, dynamic> json) {
    return ReqGetGuideBook(
      cardNumber: json['card_number'],
      birthDate: json['birth_date'],
      isPlan: json['is_plan'],
      corporate: json['corporate'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["card_number"] = cardNumber;
    map["birth_date"] = birthDate;
    map["is_plan"] = isPlan;
    map["corporate"] = corporate;
    return map;
  }
}
