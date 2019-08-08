import 'package:flutter/material.dart';
import 'package:jasindo_app/utility/colors.dart';
import 'package:jasindo_app/utility/utils.dart';
import 'package:jasindo_app/widgets/ButtonWidget.dart';

import 'nik_form.dart';

class RegisterQR extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterQRState();
  }
}

class RegisterQRState extends State<RegisterQR> {
  final _nikController = TextEditingController();
  bool _validateNIk = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "lib/assets/images/card.png",
              height: 100,
              width: MediaQuery.of(context).size.width / 3,
            ),
            _insertCard(),
            _btnSubmit()
          ],
        ),
      ),
    );
  }

  Widget _insertCard() {
    return Container(
      margin: EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 0.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        maxLength: 16,
        decoration: InputDecoration(
            labelText: 'NIK',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            errorText:
                _validateNIk ? "Pastikan NIK terisi dengan benar" : null),
        controller: _nikController,
      ),
    );
  }

  void _onSubmit() {
    setState(() {
      if (_nikController.text.length != 16) {
        _validateNIk = true;
        return;
      } else {
        _validateNIk = false;
        routeToWidget(context, NikForm(_nikController.text));
      }
    });
  }

  Widget _btnSubmit() {
    return Container(
      padding: EdgeInsets.only(left: 60, right: 60, top: 30),
      child: ButtonWidget(
          height: 40,
          txtSize: 12,
          txtColor: Colors.white,
          txt: 'NEXT',
          btnColor: blueStandart,
          borderRedius: 5,
          onClick: () => {
                _onSubmit(),
              }),
    );
  }
}
