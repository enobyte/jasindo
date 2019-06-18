class ReqGetProvider {
  final String cardNumber;
  final String birthDate;
  final String planId;
  final String city;
  final double latitude;
  final double longitude;

  ReqGetProvider({this.cardNumber, this.birthDate, this.planId, this.city, this.latitude, this.longitude});

  factory ReqGetProvider.fromJson(Map<String, dynamic> json) {
    return ReqGetProvider(
      cardNumber: json['card_number'],
      birthDate: json['birth_date'],
      planId: json['plan_id'],
      city: json['city'],
      latitude: json['latitude'],
      longitude: json['longitude'],

    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["card_number"] = cardNumber;
    map["birth_date"] = birthDate;
    map["plan_id"] = planId;
    map["city"] = city;
    map["latitude"] = latitude;
    map["longitude"] = longitude;
    return map;
  }
}
