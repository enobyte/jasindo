import 'package:flutter/material.dart';
import 'package:jasindo_app/assets/Strings.dart';
import 'package:jasindo_app/widgets/ButtonWidget.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';
import 'package:jasindo_app/widgets/pin_input/pin_put.dart';

class StepFive extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StepFiveState();
  }
}

class StepFiveState extends State<StepFive> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 40.0, top: 30.0, right: 40),
      child: Column(
        children: <Widget>[
          Icon(Icons.mail),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextWidget(
              txt: attentionVerifyMail,
              txtSize: 12,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextWidget(
              txt: 'enoraden@gmail.com',
              color: Colors.red,
              txtSize: 14,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextWidget(
              txt: attentionActiveAccount,
              txtSize: 12,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextWidget(
              txt: attentionCheckMail,
              txtSize: 8,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PinPut(
              fieldsCount: 4,
              actionButtonsEnabled: false,
              onSubmit: () => {},
            ),
          ),
          _btnAktifasi(),
          TextWidget(
            txt: attentionCodeNotSend,
            txtSize: 8,
          ),
          _btnResendCode()
        ],
      ),
    );
  }

  Widget _btnAktifasi() {
    return Container(
      margin: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 25.0),
      child: ButtonWidget(
          height: 40,
          txtSize: 12,
          txtColor: Colors.white,
          txt: 'AKTIFASI',
          btnColor: Colors.blue,
          borderRedius: 5,
          onClick: () => {debugPrint('btn success')}),
    );
  }

  Widget _btnResendCode() {
    return Container(
      margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 6, 2.0,
          MediaQuery.of(context).size.width / 6, 0.0),
      child: ButtonWidget(
          height: 30,
          txtSize: 12,
          txtColor: Colors.white,
          txt: 'KIRIM ULANG',
          btnColor: Colors.red,
          borderRedius: 5,
          onClick: () => {debugPrint('btn success')}),
    );
  }
}
