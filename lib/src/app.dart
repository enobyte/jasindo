import 'package:flutter/material.dart';
import 'package:jasindo_app/src/ui/main_menu/main_menu.dart';
import 'package:jasindo_app/src/ui/prelogin_activity.dart';

import 'ui/login_form.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'SF-Regular'),
      home: Scaffold(
        body: PreloginActivity(),
      ),
      routes: <String, WidgetBuilder>{
        '/main_menu': (BuildContext context) => new MainMenu(),
        '/prelogin_menu': (BuildContext context) => new PreloginActivity(),
        '/login_menu': (BuildContext context) => new LoginForm()
      },
    );
  }
}
