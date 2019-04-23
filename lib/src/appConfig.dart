import 'package:flutter/material.dart';

class AppConfig {
  static Flavor appFlavor;

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.RELEASE:
        return '';
      case Flavor.DEVELOPMENT:
      default:
        return 'http://api.themoviedb.org/3/movie';
    }
  }
}

enum Flavor {
  DEVELOPMENT,
  RELEASE,
}