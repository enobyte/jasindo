class ReqGetDependent {
  final String cardNumber;
  final String birthDate;
  final String employeeId;

  ReqGetDependent({this.cardNumber, this.birthDate, this.employeeId});

  factory ReqGetDependent.fromJson(Map<String, dynamic> json) {
    return ReqGetDependent(
      cardNumber: json['card_number'],
      birthDate: json['birth_date'],
      employeeId: json['employeeId'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["card_number"] = cardNumber;
    map["birth_date"] = birthDate;
    map["employeeId"] = employeeId;
    return map;
  }
}
