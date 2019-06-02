import 'package:flutter/material.dart';
import 'package:jasindo_app/src/blocs/bloc-provider.dart';
import 'package:jasindo_app/src/ui/forgot_password.dart';
import 'package:jasindo_app/src/ui/main_menu/main_menu.dart';
import 'package:jasindo_app/src/ui/registration/register_form.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  bool _isHidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextWidget(
                    txt: "Selamat Datang!", color: Colors.blue, txtSize: 24),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: "Email"),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                  child: TextFormField(
                    obscureText: _isHidePassword,
                    decoration: InputDecoration(
                        labelText: "Password",
                        suffixIcon: IconButton(
                            icon: Icon(Icons.remove_red_eye),
                            onPressed: () {
                              setState(() {
                                if (_isHidePassword) {
                                  _isHidePassword = false;
                                } else {
                                  _isHidePassword = true;
                                }
                              });
                            })),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                  alignment: FractionalOffset.centerRight,
                  child: InkWell(
                    child: TextWidget(
                        txt: "Lupa Kata Sandi", color: Colors.blue),
                    onTap: () => {
                    _openForgotPassword(context)
                  },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
                    child: ButtonTheme(
                      child: new RaisedButton(
                        child: const TextWidget(
                          color: Colors.white,
                          txt: 'LOGIN',
                          txtSize: 12.0,
                        ),
                        elevation: 4.0,
                        color: Colors.blue,
                        splashColor: Colors.blueAccent,
                        onPressed: () {
                          _openMainMenu(context);
                        },
                      ),
                      height: 50.0,
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Spacer(flex: 20),
                      TextWidget(txt: "Pengguna Baru?"),
                      Spacer(flex: 1),
                      GestureDetector(
                        child: TextWidget(txt: "DAFTAR", color: Colors.blue),
                        onTap: () => {_openRegisterForm(context)},
                      ),
                      Spacer(flex: 20),
                    ],
                  ),
                )
              ],
            ),
          )),
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

  _openMainMenu(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, "/main_menu", (_) => false);
  }

  _openForgotPassword(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return BlocProvider(
          child: ForgotPassword(),
        );
      }),
    );
  }
}
