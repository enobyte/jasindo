import 'package:flutter/material.dart';
import 'package:jasindo_app/src/blocs/bloc-provider.dart';
import 'package:jasindo_app/src/ui/login_form.dart';
import 'package:jasindo_app/src/ui/registration/register_form.dart';
import 'package:jasindo_app/utility/colors.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class PreloginActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[background(), _logo(context), buttonComponet(context)],
    );
  }

  Widget _logo(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 8),
      child: Image.asset(
        'lib/assets/images/logo_medium.png',
      ),
      alignment: FractionalOffset.topCenter,
      decoration: BoxDecoration(color: Colors.transparent),
    );
  }

  Widget background() {
    return new Container(
      child: Image.asset(
        'lib/assets/images/login_img.png',
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
        padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ButtonTheme(
              child: new RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: TextWidget(
                  color: Colors.white,
                  txt: 'LOGIN',
                  txtSize: 18.0,
                ),
                elevation: 4.0,
                color: blueStandart,
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: new RaisedButton(
                  child: TextWidget(
                    color: Colors.white,
                    txt: 'DAFTAR',
                    txtSize: 18.0,
                  ),
                  elevation: 4.0,
                  color: btnColorOrange,
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
