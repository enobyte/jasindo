class ReqMessages {
  final String email;
  final String subject;
  final String messages;

  ReqMessages({this.email, this.subject, this.messages});

  factory ReqMessages.fromJson(Map<String, dynamic> json) {
    return ReqMessages(
      email: json['email'],
      subject: json['subject'],
      messages: json['messages'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["email"] = email;
    map["subject"] = subject;
    map["messages"] = messages;
    return map;
  }
}
