

class AppConfig {
  static Flavor appFlavor;

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.RELEASE:
        return 'http://103.107.103.56:8000/api';
      case Flavor.DEVELOPMENT:
        return 'http://103.107.103.56:8000/api';
      default:
        return 'http://103.107.103.56:8000/api';
    }
  }
}

enum Flavor {
  DEVELOPMENT,
  RELEASE,
}