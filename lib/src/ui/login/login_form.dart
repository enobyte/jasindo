import 'package:flutter/material.dart';
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
            TextWidget(txt: "Selamat Datang!", color: Colors.blue, txtSize: 24),
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
              alignment: FractionalOffset.centerRight,
              child: TextWidget(txt: "Lupa Password", color: Colors.blue),
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
                      // Perform some action
                    },
                  ),
                  height: 50.0,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(flex: 20),
                  TextWidget(txt: "Pengguna Baru?"),
                  Spacer(flex: 1),
                  TextWidget(txt: "Daftar", color: Colors.blue),
                  Spacer(flex: 20),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
