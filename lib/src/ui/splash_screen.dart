import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:jasindo_app/src/blocs/notification_bloc.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:jasindo_app/widgets/ImageSvg.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

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
    _firebaseCloudMessaging();
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

  void _firebaseCloudMessaging() {
    if (Platform.isIOS) iOSPermission();
    _firebaseMessaging.getToken().then((token) {
      SharedPreferencesHelper.setTokenFirebase(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        if (message['data']['app'] == 'btnDischarge') {
          bloc.notifDischargeBloc(message);
        }
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOSPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}
