import 'package:flutter/material.dart';
import 'package:jasindo_app/src/ui/movie_list.dart';
import 'package:jasindo_app/src/ui/prelogin_activity.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        body: PreloginActivity(),
      ),
      routes: <String, WidgetBuilder> {
        //'/mainposting': (BuildContext context) => new MainPosting()
      },
    );
  }
}
