import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jasindo_app/src/blocs/bloc-provider.dart';
import 'package:intl/intl.dart';

Future<String> randomString() async {
  const chars = "abcdefghijklmnopqrstuvwxyz";
  Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
  String result = "";
  for (var i = 0; i < 4; i++) {
    result += chars[rnd.nextInt(chars.length)];
  }
  return result.toUpperCase();
}

Future<Widget> routeToWidget(BuildContext context, Widget widget) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      return BlocProvider(
        child: widget,
      );
    }),
  );
}

showToast(BuildContext context, String message) {
  return Scaffold.of(context).showSnackBar(new SnackBar(
    content: new Text(message),
  ));
}

bool validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return false;
  else
    return true;
}

String formatDateFormStandart(String value, String format) {
  var datetime = DateTime.parse(value);
  return DateFormat(format).format(datetime);
}

//Use yyyymmdd
String formatDate(String value, String format) {
  print(value);
  value = value + 'T132700';
  var datetime = DateTime.parse(value);
  return DateFormat(format).format(datetime);
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}

String mmmTomm(String mmm) {
  String mm;
  switch (mmm) {
    case "JAN":
      mm = "01";
      break;
    case "FEB":
      mm = "02";
      break;
    case "MAR":
      mm = "03";
      break;
    case "APR":
      mm = "04";
      break;
    case "MAY":
      mm = "05";
      break;
    case "JUN":
      mm = "06";
      break;
    case "JUL":
      mm = "07";
      break;
    case "AUG":
      mm = "08";
      break;
    case "SEP":
      mm = "01";
      break;
    case "OCT":
      mm = "10";
      break;
    case "NOV":
      mm = "11";
      break;
    case "DEC":
      mm = "12";
      break;
  }
  return mm;
}
