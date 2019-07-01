import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:jasindo_app/widgets/ImageSvg.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    SharedPreferencesHelper.getToken().then((onValue) {
      if (onValue.isNotEmpty) {
        Navigator.of(context).pushReplacementNamed('/main_menu');
      } else {
        Navigator.of(context).pushReplacementNamed('/prelogin_menu');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.width / 2,
        width: MediaQuery.of(context).size.width / 2,
        child:
            ImageSvg(isNetwork: false, pathImage: 'lib/assets/images/logo.svg'),
      ),
    );
  }
}
