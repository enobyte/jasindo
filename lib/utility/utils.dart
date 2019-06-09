import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jasindo_app/src/blocs/bloc-provider.dart';

String randomString() {
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
