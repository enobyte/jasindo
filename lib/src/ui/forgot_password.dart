import 'package:flutter/material.dart';
import 'package:jasindo_app/assets/Strings.dart';
import 'package:jasindo_app/widgets/ButtonWidget.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ForgotPasswordState();
  }
}

class ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextWidget(
              txt: titleForgotPass,
              color: Colors.blue,
              txtSize: 24,
              align: TextAlign.left,
            ),
            SizedBox(
              height: 10,
            ),
            TextWidget(
                txt: descFortgotPass, txtSize: 12, align: TextAlign.left),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
              child: TextFormField(
                decoration: InputDecoration(labelText: "Email"),
              ),
            ),
            ButtonWidget(
                height: 40,
                txtSize: 12,
                txtColor: Colors.white,
                txt: 'KIRIM',
                btnColor: Colors.blue,
                borderRedius: 5,
                onClick: () => {debugPrint('btn success')}),
          ],
        ),
      ),
    );
  }
}
