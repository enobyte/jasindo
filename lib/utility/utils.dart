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

//Use yyyymmdd
String formatDate(String value){
  value = value+'T132700';
  var datetime = DateTime.parse(value);
  return DateFormat("dd-MMM-yyyy").format(datetime);
}
