import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jasindo_app/src/app.dart';

void main() {
  //Used Like This : var config = AppConfig.of(context);
  //AppConfig.appFlavor = Flavor.DEVELOPMENT;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new App());
  });
}
