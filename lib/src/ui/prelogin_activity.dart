import 'package:flutter/material.dart';
import 'package:jasindo_app/src/blocs/bloc-provider.dart';
import 'package:jasindo_app/src/ui/login_form.dart';
import 'package:jasindo_app/src/ui/registration/register_form.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class PreloginActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[background(), buttonComponet(context)],
    );
  }

  Widget background() {
    return new Container(
      child: Image.asset(
        'lib/assets/images/logo_title.png',
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.fitWidth,
      ),
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(color: Colors.white),
    );
  }

  Widget buttonComponet(BuildContext context) {
    return new Positioned(
      bottom: MediaQuery.of(context).size.height / 20,
      left: 0.5,
      right: 0.5,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ButtonTheme(
              child: new RaisedButton(
                child: const TextWidget(
                  color: Colors.white,
                  txt: 'LOGIN',
                  txtSize: 18.0,
                ),
                elevation: 4.0,
                color: Color.fromRGBO(0, 96, 153, 1.0),
                splashColor: Colors.blueGrey,
                onPressed: () {
                  _openLoginForm(context);
                },
              ),
              height: 50.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
              child: ButtonTheme(
                child: new RaisedButton(
                  child: const TextWidget(
                    color: Colors.white,
                    txt: 'DAFTAR',
                    txtSize: 18.0,
                  ),
                  elevation: 4.0,
                  color: Color.fromRGBO(226, 162, 93, 1.0),
                  splashColor: Colors.blueGrey,
                  onPressed: () {
                    _openRegisterForm(context);
                  },
                ),
                height: 50.0,
              ),
            )
          ],
        ),
      ),
    );
  }

  _openLoginForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return BlocProvider(
          child: LoginForm(),
        );
      }),
    );
  }

  _openRegisterForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return BlocProvider(
          child: RegisterForm(),
        );
      }),
    );
  }
}
