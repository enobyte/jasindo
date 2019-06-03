import 'package:flutter/material.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class ChangePassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChangePasswordState();
  }
}

class ChangePasswordState extends State<ChangePassword> {
  bool _isHidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: TextWidget(
            txt: 'Ubah Kata Sandi', color: Colors.black,
          )),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextFormField(
              obscureText: _isHidePassword,
              decoration: InputDecoration(
                  labelText: "Masukkan Kata Sandi Lama",
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
            SizedBox(height: 20),
            TextFormField(
              obscureText: _isHidePassword,
              decoration: InputDecoration(
                  labelText: "Masukkan Kata Sandi Baru",
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
            SizedBox(height: 20),
            TextFormField(
              obscureText: _isHidePassword,
              decoration: InputDecoration(
                  labelText: "Ulangi Kata Sandi Baru",
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
            SizedBox(height: 50),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: RaisedButton(
                color: Colors.blue,
                onPressed: () => {},
                child: Container(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child: TextWidget(txt: 'SIMPAN', color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
