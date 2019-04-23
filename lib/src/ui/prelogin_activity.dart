import 'package:flutter/material.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class PreloginActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[background(), buttonComponet()],
    );
  }

  Widget background() {
    return new Container(
      child: Image.asset('lib/assets/images/login_img.png'),
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(color: Colors.white),
    );
  }

  Widget buttonComponet() {
    return new Positioned(
      bottom: 48.0,
      left: 0.5,
      right: 0.5,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ButtonTheme(
              child: new RaisedButton(
                child: const TextWidget(
                  color: Colors.white,
                  txt: 'Member',
                  txtSize: 18.0,
                ),
                elevation: 4.0,
                color: Colors.blue,
                splashColor: Colors.blueGrey,
                onPressed: () {
                  // Perform some action
                },
              ),
              height: 50.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
              child: new TextWidget(
                color: Colors.blueAccent,
                txt: 'Non Member',
                txtSize: 12.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
