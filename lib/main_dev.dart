import 'package:flutter/material.dart';
import 'package:jasindo_app/src/app.dart';
import 'package:jasindo_app/src/appConfig.dart';

void main() {

  //Used Like This : var config = AppConfig.of(context);
  AppConfig.appFlavor = Flavor.DEVELOPMENT;

  runApp(new App());
}
